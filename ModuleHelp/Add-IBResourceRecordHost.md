---
external help file: InfoBlox-help.xml
online version: 
schema: 2.0.0
---

# Add-IBResourceRecordHost
## SYNOPSIS
Add a host record on the Infoblox Gridserver

## SYNTAX

```
Add-IBResourceRecordHost [-IPv4Address] <String> [-HostName] <String> [[-Comment] <String>]
 [-GridServer] <String> [-Credential] <PSCredential> [-CreateInDNS] [-WhatIf] [-Confirm]
```

## DESCRIPTION
This cmdlet creates a host object on the Infoblox Gridserver.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
Add-IBResourceRecordHost -IPv4Address '1.2.3.4' -HostName 'myserver.mydomain.com' -GridServer myinfoblox.mydomain.com -Credential $Credential
```

Create new IP record with address 1.2.3.4 and host name myserver.mydomain.com

## PARAMETERS

### -IPv4Address
The IPv4 address for the host record.
Allows pipeline input.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: 1
Default value: (Read-Host -Promp 'IP4 address')
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -HostName
The hostname for the host record.
Allows pipeline input.

```yaml
Type: String
Parameter Sets: (All)
Aliases: Name

Required: True
Position: 2
Default value: (Read-Host -Prompt 'Hostname')
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Comment
The comment text for the host record.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: 3
Default value: [string]::Empty
Accept pipeline input: False
Accept wildcard characters: False
```

### -GridServer
The name of the infoblox appliance.
Allows pipeline input.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: 4
Default value: (Read-Host -Prompt 'InfoBlox Grid server')
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Credential
The credential to authenticate to the grid server with.

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases: 

Required: True
Position: 5
Default value: (Get-Credential -Message 'InfoBlox credential')
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -CreateInDNS
Switch to indicate whether to create a DNS record as well.
Default is FALSE.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Do not create resource record, just show -WhatIf message.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Confirm action before executing.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

