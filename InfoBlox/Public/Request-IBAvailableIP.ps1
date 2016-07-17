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
    [cmdletbinding(SupportsShouldProcess = $true)]
    param(
        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [string]$GridServer = (Read-Host -Prompt 'InfoBlox Grid server'),

        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [pscredential]$Credential = (Get-Credential -Message 'InfoBlox credential'),

        [Parameter(Mandatory)]
        [string]$Network = (Read-Host -Prompt 'Network'),

        [Parameter(Mandatory)]
        [string]$Name = (Read-Host -Prompt 'Hostname'),

        [string]$Comment = [string]::Empty,

        [switch]$ConfigureForDNS
    )

    begin {
        $apiVersion = $script:apiVersion
    }

    process {
        Write-Debug -Message "Searching for host record [$Name]"

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
            Write-Debug -Message "Host [$Name] not found. Continuing..."
            $net = Get-IBNetwork -GridServer $GridServer -Credential $Credential -Network $Network

            if ($null -ne $net) {
                Write-Verbose -Message "Found network [$($Net._ref)]"

                Write-Verbose -Message 'Searching for next available IP:'
                $availableIP = Get-IBNextAvailableIP -GridServer $GridServer -Credential $Credential -NetworkRef $net._ref -Quantity 1

                if ($null -ne $availableIP) {
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

                    if ($PSCmdlet.ShouldProcess($Network, 'Request InfoBlox available IP')) {
                        $hostRef = Add-IBResourceRecordHost @params
                        if ($null -ne $hostRef) {
                            $uri = "https://$GridServer/wapi/v$apiVersion/$hostRef"
                            $result = Invoke-RestMethod -Uri $uri -Credential $Credential
                            return $result.ipv4addrs
                        } else {
                            Write-Error -Message "Failed to allocate host record for IP [$availableIP]"
                        }
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