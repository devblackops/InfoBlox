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

function Get-IBResourceRecord {
    <#
    .SYNOPSIS
        Retrieves resource records from an Infoblox Gridserver

    .DESCRIPTION
        Specify an attribute to search for, for example hostname and retrieve the object from the Gridserver

    .EXAMPLE
        Get-IBResourceRecord -Type host -SearchField MyServer -GridServer myinfoblox.mydomain.com -Credential $Credential

    .EXAMPLE
        Get-IBResourceRecord -Type network -SearchField 1.0.0.0/8 -GridServer myinfoblox.mydomain.com -Credential $Credential -Passthrough

    .PARAMETER Type
        Specify the type of record, for example host or network.

    .PARAMETER SearchField
        The field where the RecordValue is. Default is "Name".

    .PARAMETER SearchText
        The value to search for.

    .PARAMETER GridServer
        The name of the infoblox appliance.

    .PARAMETER Properties
        What properties should be included?

    .PARAMETER Credential
        The credential to authenticate to the grid server with.

    .PARAMETER Passthrough
        Includes credentials and gridserver in the object sent down the pipeline so you don't need to add them in the next cmdlet.
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [ValidateSet('A', 'AAAA','CName', 'DName', 'DNSKEY', 'DS', 'Host', 'LBDN', 'MX', 'NAPTR','NS', 'NSEC', 'NSEC3', 'NSEC3PARAM', 'PTR', 'RRSIG', 'SRV', 'TXT')]
        [string]$Type = 'A',

        [string]$SearchField = 'name',

        [Parameter(Mandatory)]
        [string]$SearchText = (Read-Host -Prompt 'Search text'),

        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [string]$GridServer = (Read-Host -Prompt 'InfoBlox Grid server'),

        [string[]]$Properties = [string[]],

        [switch]$Passthrough,

        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [pscredential]$Credential = (Get-Credential -Message 'InfoBlox credential')
    )

    begin {
        $apiVersion = $script:apiVersion
    }

    process {
        $uri = "https://$GridServer/wapi/v$apiVersion/record:$($Type.ToLower())?$($SearchField.ToLower())~:=$SearchText"

        if ($PSBoundParameters.ContainsKey('Properties')) {
            $uri = "$uri&_return_fields=$(($Properties -join "," -replace " ").ToLower())"
        }

        $obj = Invoke-RestMethod -Uri $uri -Credential $Credential

        foreach ($record in $obj) {
            $returnObject = $null
            $returnObject = $record
            if ($Passthrough -eq $true) {
                $returnObject | Add-Member -Type NoteProperty -Name Credential -Value $Credential
                $returnObject | Add-Member -Type NoteProperty -Name GridServer -Value $GridServer
            }

            Write-Output -InputObject $returnObject
        }
    }

    end { }
}