---
external help file: InfoBlox-help.xml
online version: 
schema: 2.0.0
---

# Remove-IBResourceRecord
## SYNOPSIS
Removes a host record from an Infoblox Gridserver

## SYNTAX

```
Remove-IBResourceRecord [-Reference] <String> [-GridServer] <String> [-Credential] <PSCredential> [-WhatIf]
 [-Confirm]
```

## DESCRIPTION
This cmdlet removes a host object from an Infoblox Gridserver.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
Remove-IBResourceRecord -Reference $ref -GridServer myinfoblox.mydomain.com -Credential $Credential
```

Remove a resource record

## PARAMETERS

### -Reference
The object reference for the host record.
Allows pipeline input.

```yaml
Type: String
Parameter Sets: (All)
Aliases: _ref

Required: True
Position: 1
Default value: (Read-Host -Prompt 'Network reference')
Accept pipeline input: True (ByPropertyName, ByValue)
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
Position: 2
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
Position: 3
Default value: (Get-Credential -Message 'InfoBlox credential')
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -WhatIf
Do not remove address record, just show -WhatIf message.

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

