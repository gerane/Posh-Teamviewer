---
external help file: Posh-Teamviewer-help.xml
schema: 2.0.0
---

# Initialize-Teamviewer
## SYNOPSIS
Reads the Teamviewer AccessToken stored in the Users Appdata Folder and creates a DeviceList.
## SYNTAX

```
Initialize-Teamviewer [-MasterPassword] <SecureString> [<CommonParameters>]
```

## DESCRIPTION
Reads the Teamviewer AccessToken stored in the Users $env:Appdata\Teamviewer Folder and sets a Global variable with it's SecureString value. Queries the Teamviewer Api to create a Device List and stores it as a Global variable.
## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\> Initialize-Teamviewer -MasterPassword $SecureString
```

Reads the Teamviewer AccessToken and sets the $Global:TeamviewerAccessToken variable with it's SecureString Value. Builds a Device List and sets it as $Global:TeamviewerDeviceList Variable
### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\> Initialize-Teamviewer
```

Prompts the user for their MasterPassword and then reads the Teamviewer AccessToken and sets the `$Global:TeamviewerAccessToken variable. Builds a Device List and sets it as $Global:TeamviewerDeviceList Variable
## PARAMETERS

### -MasterPassword
The Master Password the AccessToken was Encrypted with using Set-TeamviewerAccessToken.



```yaml
Type: SecureString
Parameter Sets: (All)
Aliases: 

Required: True
Position: 0
Default value: 
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).
## INPUTS

### System.Security.SecureString

## OUTPUTS

### System.Object

## NOTES
Special thanks to Carlos Perez for the AccessToken Encryption Code.
## RELATED LINKS

[Online Version](http://posh-teamviewer.readthedocs.io/en/latest/Commands/Initialize-Teamviewer/)

[Markdown Version](https://github.com/gerane/Posh-Teamviewer/blob/master/docs/Commands/Initialize-Teamviewer.md)

[Documentation](https://readthedocs.org/projects/posh-teamviewer/)

[PSGallery](https://www.powershellgallery.com/packages/posh-teamviewer/)

[Carlos Perez Github](https://github.com/darkoperator)

[Create Teamviewer Access Token](https://integrate.teamviewer.com/en/develop/api/get-started/#createScript)

[Teamviewer Api Documentation:](https://integrate.teamviewer.com/en/develop/api/)




