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

function Remove-IBResourceRecord {
    <#
    .SYNOPSIS
        Removes a host record from an Infoblox Gridserver

    .DESCRIPTION
        This cmdlet removes a host object from an Infoblox Gridserver.

    .EXAMPLE
        Remove-IBResourceRecord -Reference $ref -GridServer myinfoblox.mydomain.com -Credential $Credential

        Remove a resource record

    .PARAMETER Reference
        The object reference for the host record. Allows pipeline input.

    .PARAMETER GridServer
        The name of the infoblox appliance. Allows pipeline input.

    .PARAMETER Credential
        The credential to authenticate to the grid server with.

    .PARAMETER WhatIf
        Do not remove address record, just show -WhatIf message.

    .PARAMETER Confirm
        Confirm action before executing.
    #>
    [cmdletbinding(SupportsShouldProcess = $true)]
    param(
        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [Alias('_ref')]
        [string]$Reference = (Read-Host -Prompt 'Network reference'),

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

        if ($PSCmdlet.ShouldProcess($Reference, 'Remove InfoBlox record')) {
            $request = Invoke-RestMethod -Uri $uri -Method Delete -Credential $Credential
            return $request
        }
    }

    end {}
}