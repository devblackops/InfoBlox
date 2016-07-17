---
external help file: InfoBlox-help.xml
online version: 
schema: 2.0.0
---

# Get-IBNetwork
## SYNOPSIS
Retrieves networks from an Infoblox Gridserver

## SYNTAX

```
Get-IBNetwork [-GridServer] <String> [-Credential] <PSCredential> [[-Network] <String>]
 [[-Properties] <String[]>]
```

## DESCRIPTION
Specify an attribute to search for, for example hostname and retrieve the object from the Gridserver

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
Get-IBNetwork -GridServer myinfoblox.mydomain.com -Credential $Credential -Network '1.2.3.0/24'
```

Retrieve the network called 1.2.3.0/24

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
The network name to get.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: 3
Default value: *
Accept pipeline input: False
Accept wildcard characters: False
```

### -Properties
Additional properties to retrieve with the network object.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: 4
Default value: String[]
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

## OUTPUTS

### System.Object[]

## NOTES

## RELATED LINKS

