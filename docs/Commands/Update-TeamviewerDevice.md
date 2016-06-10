---
external help file: Posh-Teamviewer-help.xml
schema: 2.0.0
---

# Update-TeamviewerDevice
## SYNOPSIS
Updates Properties of a Teamviewer Device.
## SYNTAX

```
Update-TeamviewerDevice [-ComputerName] <String> [[-Description] <String>] [[-Alias] <String>]
 [[-Password] <String>] [-UpdateDeviceList] [[-AccessToken] <SecureString>] [<CommonParameters>]
```

## DESCRIPTION
Updates Properties of a Teamviewer Device. Those properties are Alias(Device's Name), Description, and Password. 
## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\> Update-TeamviewerDevice -ComputerName 'Test1' -Description 'Test Lab Device 1' -Alias 'Test1 (Test Lab)'
```

This command updates the Teamviewer Description and Alias of the Device named 'Test1'.
### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\> Update-TeamviewerDevice -ComputerName 'Test1' -Password $NewPassword
```

This command updates the Teamviewer Password of the Device named 'Test1'.
## PARAMETERS

### -AccessToken
The Teamviewer AccessToken






```yaml
Type: SecureString
Parameter Sets: (All)
Aliases: 

Required: False
Position: 4
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -Alias
The new Name of the Device.






```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: 2
Default value: 
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ComputerName
The Name of the Device.






```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: 0
Default value: 
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Description
The Description of the Device.






```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: 1
Default value: 
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Password
The new Password for the Device. This is not the Password set by the Client, but the one saved in Teamviewer for connecting without a Password.






```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: 3
Default value: 
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -UpdateDeviceList
Update the Devices List Global Variable that the Device information is stored. Teamviewer accounts with a large device list can take a very long time to send a response back with Device Ids. To get around this Device information is gathered and stored when Initialize-Teamviewer is ran to decrypt the Teamviewer Access Token. This allows quick Device information look up. 






```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).
## INPUTS

### System.String
System.Management.Automation.SwitchParameter
## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS

[Online Version](http://posh-teamviewer.readthedocs.io/en/latest/Commands/Set-TeamviewerDeviceList/)

[Markdown Version](https://github.com/gerane/Posh-Teamviewer/blob/master/docs/Commands/Set-TeamviewerDeviceList.md)

[Documentation](https://readthedocs.org/projects/posh-teamviewer/)

[PSGallery](https://www.powershellgallery.com/packages/posh-teamviewer/)

[Create Teamviewer Access Token](https://integrate.teamviewer.com/en/develop/api/get-started/#createScript)

[Teamviewer Api Documentation:](https://integrate.teamviewer.com/en/develop/api/)







