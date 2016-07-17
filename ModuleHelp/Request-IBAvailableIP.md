---
external help file: InfoBlox-help.xml
online version: 
schema: 2.0.0
---

# Request-IBAvailableIP
## SYNOPSIS
Reservers an available IP from a Infoblox Gridserver

## SYNTAX

```
Request-IBAvailableIP [-GridServer] <String> [-Credential] <PSCredential> [-Network] <String> [-Name] <String>
 [[-Comment] <String>] [-ConfigureForDNS] [-WhatIf] [-Confirm]
```

## DESCRIPTION
Specify an attribute to search for, for example hostname and retrieve the object from the Gridserver

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
Request-IBAvailableIP -GridServer myinfoblox.mydomain.com -Credential $Credential -Network '1.2.3.0/24' -Name 'server01' -Comment 'test server'
```

Allocate an IP address from network 1.2.3.0/24 and give it a host name of server01.

## PARAMETERS

### -GridServer
The name of the infoblox appliance.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: 1
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
Position: 2
Default value: (Get-Credential -Message 'InfoBlox credential')
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Network
The network to request an IP from.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: 3
Default value: (Read-Host -Prompt 'Network')
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
The hostname for the host record.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: 4
Default value: (Read-Host -Prompt 'Hostname')
Accept pipeline input: False
Accept wildcard characters: False
```

### -Comment
The comment text for the host record.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: 5
Default value: [string]::Empty
Accept pipeline input: False
Accept wildcard characters: False
```

### -ConfigureForDNS
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
Do not request IP address, just show -WhatIf message.

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

