[![Build status](https://ci.appveyor.com/api/projects/status/wxg7eyc0ygs9jeo8?svg=true)](https://ci.appveyor.com/project/devblackops/infoblox)

# InfoBlox
PowerShell module for interacting with InfoBlox IPAM via the REST API.

## Examples
### Add-IBResourceRecordHost
Add a host record on the Infoblox Gridserver

`Add-IBResourceRecordHost -IPv4Address '1.2.3.4' -HostName 'myserver.mydomain.com' -GridServer myinfoblox.mydomain.com -Credential $Credential`

### Get-IBNetwork
Retrieves networks from an Infoblox Gridserver

`Get-IBNetwork -GridServer myinfoblox.mydomain.com -Credential $Credential -Network '1.2.3.0/24'``

### Get-IBNextAvailableIP
Retrieves available IP addresses from an Infoblox Gridserver

`Get-IBNextAvailableIP -GridServer myinfoblox.mydomain.com -Credential $Credential -NetworkRef $ref -Quantity 10`

### Get-IBResourceRecord
Retrieves resource records from a Infoblox Gridserver

`Get-IBResourceRecord -Type host -SearchField MyServer -GridServer myinfoblox.mydomain.com -Credential $Credential`

### New-IBNetwork
Adds a network to an Infoblox Gridserver

`New-IBNetwork -GridServer myinfoblox.mydomain.com -Credential $Credential -Network '10.10.1.0/24' -Comment 'My New Network'`

### New-IBNetworkContainer
Adds a network container to an Infoblox Gridserver

`New-IBNetworkContainer -GridServer myinfoblox.mydomain.com -Credential $Credential -Network '10.10.1.0/24' -Comment 'My New Network'`

### Remove-IBResourceRecord
Removes a host record from an Infoblox Gridserver

`Remove-IBResourceRecord -Reference $ref -GridServer myinfoblox.mydomain.com -Credential $Credential`

### Request-IBAvailableIP
Reservers an available IP from a Infoblox Gridserver

`Request-IBAvailableIP -GridServer myinfoblox.mydomain.com -Credential $Credential -Network '1.2.3.0/24' -Name 'server01' -Comment 'test server'`

### Set-IBResourceRecord
Changes a host record on an Infoblox Gridserver

`Set-IBResourceRecord -Reference Reference -IPv4Address '1.2.3.4' -HostName myhost.mydomain.com -GridServer myinfoblox.mydomain.com -Credential $Credential`
