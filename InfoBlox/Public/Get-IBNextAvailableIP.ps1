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

function Get-IBNextAvailableIP {
    <#
    .SYNOPSIS
        Retrieves available IP addresses from an Infoblox Gridserver

    .DESCRIPTION
        Retrieves available IP addresses from an Infoblox Gridserver

    .EXAMPLE
        Get-IBNextAvailableIP -GridServer myinfoblox.mydomain.com -Credential $Credential -NetworkRef $ref

        Retrieve the next available IP address on network contained in $ref

    .EXAMPLE
        Get-IBNextAvailableIP -GridServer myinfoblox.mydomain.com -Credential $Credential -NetworkRef $ref -Quantity 10

        Retrieve the next 10 available IP address on network contained in $ref

    .PARAMETER GridServer
        The name of the infoblox appliance.

    .PARAMETER Credential
        The credential to authenticate to the grid server with.

    .PARAMETER NetworkRef
        The reference ID of the network to request from.

    .PARAMETER Quantity
        The quantity of available IP addresses to get.
    #>
    param(
        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [string]$GridServer = (Read-Host -Prompt 'InfoBlox Grid server'),

        [Parameter(Mandatory)]
        [string]$NetworkRef = (Read-Host -Prompt 'Network object reference'),

        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [pscredential]$Credential = (Get-Credential -Message 'InfoBlox credential'),

        [int]$Quantity = 1
    )

    begin {
        $apiVersion = $script:apiVersion
        $uri = "https://$GridServer/wapi/v$apiVersion/$NetworkRef`?_function=next_available_ip&num=$Quantity"
    }

    process {
        try {
            $result = Invoke-RestMethod -Uri $uri -Method Post -Credential $Credential -ContentType 'application/json'
            return $result.ips
        } catch {
            Write-Error -Message "Unable to retrieve available IP(s) from network [$NetworkRef]"
        }
    }

    end {}
}