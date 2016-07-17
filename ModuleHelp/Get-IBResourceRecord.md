---
external help file: InfoBlox-help.xml
online version: 
schema: 2.0.0
---

# Get-IBResourceRecord
## SYNOPSIS
Retrieves resource records from an Infoblox Gridserver

## SYNTAX

```
Get-IBResourceRecord [-Type] <String> [[-SearchField] <String>] [-SearchText] <String> [-GridServer] <String>
 [[-Properties] <String[]>] [-Passthrough] [-Credential] <PSCredential>
```

## DESCRIPTION
Specify an attribute to search for, for example hostname and retrieve the object from the Gridserver

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
Get-IBResourceRecord -Type host -SearchField MyServer -GridServer myinfoblox.mydomain.com -Credential $Credential
```

Retrieve the host record object with name MyServer

### -------------------------- EXAMPLE 2 --------------------------
```
Get-IBResourceRecord -Type network -SearchField 1.0.0.0/8 -GridServer myinfoblox.mydomain.com -Credential $Credential -Passthrough
```

Retrieve the network object with name 1.0.0.0/8

## PARAMETERS

### -Type
Specify the type of record, for example host or network.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: 1
Default value: A
Accept pipeline input: False
Accept wildcard characters: False
```

### -SearchField
The field where the RecordValue is.
Default is "Name".

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: 2
Default value: Name
Accept pipeline input: False
Accept wildcard characters: False
```

### -SearchText
The value to search for.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: 3
Default value: (Read-Host -Prompt 'Search text')
Accept pipeline input: False
Accept wildcard characters: False
```

### -GridServer
The name of the infoblox appliance.

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

### -Properties
What properties should be included?

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: 5
Default value: String[]
Accept pipeline input: False
Accept wildcard characters: False
```

### -Passthrough
Includes credentials and gridserver in the object sent down the pipeline so you don't need to add them in the next cmdlet.

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

### -Credential
The credential to authenticate to the grid server with.

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases: 

Required: True
Position: 6
Default value: (Get-Credential -Message 'InfoBlox credential')
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

