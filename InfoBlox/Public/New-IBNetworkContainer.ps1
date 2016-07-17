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

function New-IBNetworkContainer {
    <#
    .SYNOPSIS
        Adds a network container to an Infoblox Gridserver

    .DESCRIPTION
        Adds a network container to an Infoblox Gridserver

    .EXAMPLE
        New-IBNetworkContainer -GridServer myinfoblox.mydomain.com -Credential $Credential -Network '10.10.1.0/24' -Comment 'My New Network'

    .PARAMETER GridServer
        The name of the infoblox appliance.

    .PARAMETER Credential
        The credential to authenticate to the grid server with.

    .PARAMETER Network
        The network to create

    .PARAMETER Comment
        The description/comment to add

    .PARAMETER WhatIf
        Do not create network container, just show -WhatIf message.

    .PARAMETER Confirm
        Confirm action before executing.
    #>
    [cmdletbinding(SupportsShouldProcess = $true)]
    param(
        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [string]$GridServer = (Read-Host -Prompt 'InfoBlox Grid server'),

        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [pscredential]$Credential = (Get-Credential -Message 'InfoBlox credential'),

        [Parameter(Mandatory)]
        [string]$Network = (Read-Host -Prompt 'Network'),

        [string]$Comment = [string]::Empty
    )

    begin {
        $apiVersion = $script:apiVersion
        $uri = "https://$GridServer/wapi/v$apiVersion/networkcontainer"
    }

    process {
        $data = @{
            network = $Network
            comment = $Comment.Trim()
        }

        $json = $data | ConvertTo-Json

        if ($PSCmdlet.ShouldProcess($Network, 'Create InfoBlox network container')) {
            $request = Invoke-RestMethod -Uri $uri -Method Post -Credential $Credential -ContentType 'application/json' -Body $json
            return $request
        }
    }

    end {}
}