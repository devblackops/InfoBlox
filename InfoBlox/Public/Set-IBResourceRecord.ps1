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