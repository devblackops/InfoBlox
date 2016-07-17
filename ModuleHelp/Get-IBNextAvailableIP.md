---
external help file: InfoBlox-help.xml
online version: 
schema: 2.0.0
---

# Get-IBNextAvailableIP
## SYNOPSIS
Retrieves available IP addresses from an Infoblox Gridserver

## SYNTAX

```
Get-IBNextAvailableIP [-GridServer] <String> [-NetworkRef] <String> [-Credential] <PSCredential>
 [[-Quantity] <Int32>]
```

## DESCRIPTION
Retrieves available IP addresses from an Infoblox Gridserver

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
Get-IBNextAvailableIP -GridServer myinfoblox.mydomain.com -Credential $Credential -NetworkRef $ref
```

Retrieve the next available IP address on network contained in $ref

### -------------------------- EXAMPLE 2 --------------------------
```
Get-IBNextAvailableIP -GridServer myinfoblox.mydomain.com -Credential $Credential -NetworkRef $ref -Quantity 10
```

Retrieve the next 10 available IP address on network contained in $ref

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

### -NetworkRef
The reference ID of the network to request from.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: 2
Default value: (Read-Host -Prompt 'Network object reference')
Accept pipeline input: False
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

### -Quantity
The quantity of available IP addresses to get.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: 

Required: False
Position: 4
Default value: 1
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

