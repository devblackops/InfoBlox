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

function _CidrToBin {
    param(
        [parameter(Mandatory)]
        [int]$cidr = (Read-Host -Prompt 'CIDR')
    )

    $cidrBin = [string]::Empty

    if($cidr -le 32) {
        [int[]]$array = (1..32)
        for($i = 0; $i -lt $array.length; $i++) {
            if($array[$i] -gt $cidr) {
                $array[$i] = '0'
            } else {
                $array[$i] = '1'
            }
        }
        $cidrBin = $array -join ''
    }
    return $cidrBin
}