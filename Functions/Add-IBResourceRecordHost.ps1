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

function Add-IBResourceRecordHost {
    <#
    .SYNOPSIS
        Add a host record on the Infoblox Gridserver

    .DESCRIPTION
        This cmdlet creates a host object on the Infoblox Gridserver.

    .EXAMPLE
        Add-IBResourceRecordHost -IPv4Address '1.2.3.4' -HostName 'myserver.mydomain.com' -GridServer myinfoblox.mydomain.com -Credential $Credential

    .PARAMETER IPv4Address
        The IPv4 address for the host record. Allows pipeline input.

    .PARAMETER HostName
        The hostname for the host record. Allows pipeline input.

    .PARAMETER Comment
        The comment text for the host record.

    .PARAMETER GridServer
        The name of the infoblox appliance. Allows pipeline input.

    .PARAMETER Credential
        The credential to authenticate to the grid server with.

    .PARAMETER CreateInDNS
        Switch to indicate whether to create a DNS record as well. Default is FALSE.
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [string]$IPv4Address,

        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [Alias('Name')]
        [string]$HostName,

        [string]$Comment,

        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [string]$GridServer,

        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [pscredential]$Credential,

        [switch]$CreateInDNS
    )

    begin {}

    process {
        $uri = "https://$GridServer/wapi/v$script:apiVersion/record:host"

        if ($PSBoundParameters.ContainsKey('CreateInDNS')) {
            $dns = $true
        } else {
            $dns = $false
        }

        $data = @{
            ipv4addrs = @(
                @{ipv4addr = $IPv4Address}
            )
            name = $HostName
            comment = $Comment.Trim()
            configure_for_dns = $dns
        }
        $json = $data | ConvertTo-Json

        $request = Invoke-RestMethod -Uri $uri -Method Post -Body $json -ContentType 'application/json' -Credential $Credential

        return $request
    }

    end {}
}