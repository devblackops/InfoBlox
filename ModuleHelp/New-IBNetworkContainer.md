---
external help file: InfoBlox-help.xml
online version: 
schema: 2.0.0
---

# New-IBNetworkContainer
## SYNOPSIS
Adds a network container to an Infoblox Gridserver

## SYNTAX

```
New-IBNetworkContainer [-GridServer] <String> [-Credential] <PSCredential> [-Network] <String>
 [[-Comment] <String>] [-WhatIf] [-Confirm]
```

## DESCRIPTION
Adds a network container to an Infoblox Gridserver

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
New-IBNetworkContainer -GridServer myinfoblox.mydomain.com -Credential $Credential -Network '10.10.1.0/24' -Comment 'My New Network'
```

Create a network container called 10.10.1.0/24

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
The network to create

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

### -Comment
The description/comment to add

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: 4
Default value: [string]::Empty
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Do not create network container, just show -WhatIf message.

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

