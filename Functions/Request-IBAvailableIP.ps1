<#
Copyright 2015 Brandon Olin

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
#>

function Request-IBAvailableIP {
    <#
    .SYNOPSIS
        Retrieves resource records from a Infoblox Gridserver

    .DESCRIPTION
        Specify an attribute to search for, for example hostname and retrieve the object from the Gridserver

    .EXAMPLE
        Get-IBResourceRecord -Type host -SearchField MyServer -GridServer myinfoblox.mydomain.com -Credential $Credential

    .EXAMPLE
        Get-IBResourceRecord -Type network -SearchField 1.0.0.0/8 -GridServer myinfoblox.mydomain.com -Credential $Credential -Passthrough

    .PARAMETER GridServer
        The name of the infoblox appliance.

    .PARAMETER Credential
        The credential to authenticate to the grid server with.

    .PARAMETER Network
        The network to request an IP from.

    .PARAMETER Name
        The hostname for the host record.

    .PARAMETER Comment
        The comment text for the host record.

    .PARAMETER ConfigureForDNS
        Switch to indicate whether to create a DNS record as well. Default is FALSE.
    #>
    param(
        [Parameter(Mandatory)]
        [string]$GridServer,

        [Parameter(Mandatory)]
        [pscredential]$Credential,

        [Parameter(Mandatory)]
        [string]$Network,

        [Parameter(Mandatory)]
        [string]$Name,

        [string]$Comment = '',

        [switch]$ConfigureForDNS
    )

    begin {}

    process {
        Write-Debug "Searching for host record [$Name]"

        $match = Get-IBResourceRecord -Type Host -SearchText $Name -GridServer $GridServer -Credential $Credential
        if ($match) {
            if ($match.Name -eq $Name) {
                $exist = $true
            } else {
                $exist = $false
            }
        } else {
            $exist = $false
        }

        if ($exist -eq $false) {
            Write-Debug "Host [$Name] not found. Continuing..."
            $net = Get-IBNetwork -GridServer $GridServer -Credential $Credential -Network $Network

            if ($net -ne $null) {
                write-verbose "Found network [$($Net._ref)]"

                write-verbose 'Searching for next available IP:'
                $availableIP = Get-IBNextAvailableIP -GridServer $GridServer -Credential $Credential -NetworkRef $net._ref -Quantity 1

                if ($availableIP -ne $null) {
                    $params = @{
                        GridServer = $GridServer
                        Credential = $Credential
                        IPv4Address = $availableIP
                        HostName = $Name
                        Comment = $Comment
                    }
                    if ($PSBoundParameters.ContainsKey('ConfigureForDNS')) {
                        $params.CreateInDNS = $true
                    }
                    $hostRef = Add-IBResourceRecordHost @params

                    if ($hostRef -ne $null) {
                        $uri = "https://$GridServer/wapi/v$script:apiVersion/$hostRef"
                        $result = Invoke-RestMethod -Uri $uri -Credential $Credential
                        return $result.ipv4addrs
                    } else {
                        Write-Error -Message "Failed to allocate host record for IP [$availableIP]"
                    }
                } else {
                    Write-Error -Message "There are no available IPs on network [$Network]"
                }
            } else {
                Write-Error -Message "Could not find network [$Network]"
            }
        } else {
            Write-Error -Message "There is already a host record with name [$Name]"
        }
    }

    end {}
}