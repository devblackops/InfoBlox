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

function Get-IBNetwork {
    <#
    .SYNOPSIS
        Retrieves networks from an Infoblox Gridserver

    .DESCRIPTION
        Specify an attribute to search for, for example hostname and retrieve the object from the Gridserver

    .EXAMPLE
        Get-IBNetwork -GridServer myinfoblox.mydomain.com -Credential $Credential -Network '1.2.3.0/24'    

    .PARAMETER GridServer
        The name of the infoblox appliance.

    .PARAMETER Credential
        The credential to authenticate to the grid server with.

    .PARAMETER Network
        The network name to get.

    .PARAMETER Properties
        Additional properties to retrieve with the network object.
    #>
    
    [OutputType([system.object[]])]
    [cmdletbinding()]
    param(
        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [string]$GridServer = (Read-Host -Prompt 'InfoBlox Grid server'),

        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [pscredential]$Credential = (Get-Credential -Message 'InfoBlox credential'),

        [string]$Network = '*',

        [string[]]$Properties = [string[]]
    )

    begin {
        $apiVersion = '1.0'
        $uri = "https://$GridServer/wapi/v$apiVersion/network"
    }

    process {
        $matches = (Invoke-restmethod -Uri $uri -Method Get -Credential $Credential -ContentType 'application/json') | Where-Object Network -Like $Network

        $result = @()
        $matches | ForEach-Object {
            $x = Invoke-RestMethod -Uri "https://$GridServer/wapi/v$apiVersion/network?network=$($_.network)&_return_fields=extensible_attributes" -Method Get -Credential $Credential -ContentType 'application/json'
            
            Write-Information -MessageData $x

            # Add subnet mask and gateway
            $cidr = $_.network.split('/')[1]
            $sn = _BinToDec -binary (_CidrToBin -cidr $cidr)
            $_ | Add-Member -Type NoteProperty -Name subnetMask -Value $sn
            $_ | Add-Member -Type NoteProperty -Name gateway -Value $x.extensible_attributes.Gateway
            $_ | Add-Member -Type NoteProperty -Name extensible_attributes -Value $x.extensible_attributes
            $result += $_
        }
        return $result
    }

    end {}
}