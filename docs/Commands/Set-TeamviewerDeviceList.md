---
external help file: Posh-Teamviewer-help.xml
schema: 2.0.0
---

# Set-TeamviewerDeviceList
## SYNOPSIS
Creates a Device List Global Variable with Teamviewer Device Information.
## SYNTAX

```
Set-TeamviewerDeviceList [[-AccessToken] <SecureString>] [<CommonParameters>]
```

## DESCRIPTION
Creates a Global Variable $Global:TeamviewerDeviceList with a Device List with Teamviewer Device Information that other commands can use without relying on the Teamviewer Api. The Teamviewer Api can be slow if querying a large number of devices.
## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\> Set-TeamviewerDeviceList
```

Sets the Device List Global Variable.
## PARAMETERS

### -AccessToken
The Teamviewer Access Token.






```yaml
Type: SecureString
Parameter Sets: (All)
Aliases: 

Required: False
Position: 0
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).
## INPUTS

### None

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










