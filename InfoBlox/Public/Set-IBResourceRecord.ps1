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

function Set-IBResourceRecord {
    <#
    .SYNOPSIS
        Changes a host record on an Infoblox Gridserver

    .DESCRIPTION
        This cmdlet changes a host object on an Infoblox Gridserver.

    .EXAMPLE
        Set-IBResourceRecord -Reference Reference -IPv4Address '1.2.3.4' -HostName myhost.mydomain.com -GridServer myinfoblox.mydomain.com -Credential $Credential

    .EXAMPLE
        Get-IBResourceRecord -Type host -SeachText 'MyHost' -GridServer 'myinfoblox.mydomain.com' -Credential $Credential -Passthrough | Set-IBResourceRecord -IPv4Address '2.3.4.5'

    .PARAMETER Reference
        The object reference for the host record. Allows pipeline input.

    .PARAMETER IPv4Address
        The new IPv4 address for the host record.

    .PARAMETER HostName
        The new HostName for the host record.

    .PARAMETER GridServer
        The name of the infoblox appliance. Allows pipeline input.

    .PARAMETER Credential
        The credential to authenticate to the grid server with.

    .PARAMETER WhatIf
        Do not update record, just show -WhatIf message.
    #>
    [cmdletbinding(SupportsShouldProcess = $true)]
    param(
        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [Alias('_ref')]
        [string]$Reference = (Read-Host -Prompt 'Network reference'),

        [Parameter(Mandatory)]
        [string]$IPv4Address = (Read-Host -Prompt 'IP4 address'),

        [Parameter(Mandatory)]
        [string]$HostName = (Read-Host -Prompt 'Hostname'),

        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [string]$GridServer = (Read-Host -Prompt 'InfoBlox Grid server'),

        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [pscredential]$Credential = (Get-Credential -Message 'InfoBlox credential')
    )

    begin {
        $apiVersion = $script:apiVersion
    }

    process {
        $uri = "https://$GridServer/wapi/v$apiVersion/$Reference"

        $data = @{
            ipv4addrs = @(
                @{ipv4addr = $IPv4Address}
            )
        }
        $json = $data | ConvertTo-Json

        if ($PSCmdlet.ShouldProcess($Reference, 'Edit InfoBlox resource record')) {
            $result = Invoke-RestMethod -Uri $uri -Method Put -Body $json -ContentType 'application/json' -Credential $Credential
            return $result
        }
    }

    end {}
}