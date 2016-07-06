---
external help file: Posh-Teamviewer-help.xml
schema: 2.0.0
---

# Set-TeamviewerAccessToken
## SYNOPSIS
Encrypts the User's Teamviewer AccessToken and sets the SecureString value as a Global Variable.
## SYNTAX

```
Set-TeamviewerAccessToken -AccessToken <SecureString> [-MasterPassword] <SecureString> [<CommonParameters>]
```

## DESCRIPTION
Encrypts the User's Teamviewer AccessToken with a Master Password and sets the SecureString value as $Global:TeamviewerAccessToken Variable.
## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\> Set-TeamviewerAccessToken -AccessToken $SecureAccessTokenString -MasterPassword $SecureString
```

Sets the AccessToken using the supplied Secure String Password.
### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\> Set-TeamviewerAccessToken
```

Prompts the User for their Master Password and AccessToken.
## PARAMETERS

### -AccessToken
The Teamviewer Access Token.




```yaml
Type: SecureString
Parameter Sets: (All)
Aliases: 

Required: True
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -MasterPassword
The Master Password the AccessToken will be Encrypted with.




```yaml
Type: SecureString
Parameter Sets: (All)
Aliases: 

Required: True
Position: 1
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

[Online Version](http://posh-teamviewer.readthedocs.io/en/latest/Commands/Set-TeamviewerAccessToken/)

[Markdown Version](https://github.com/gerane/Posh-Teamviewer/blob/master/docs/Commands/Set-TeamviewerAccessToken.md)

[Documentation](https://readthedocs.org/projects/posh-teamviewer/)

[PSGallery](https://www.powershellgallery.com/packages/posh-teamviewer/)

[Carlos Perez Github](https://github.com/darkoperator)

[Create Teamviewer Access Token](https://integrate.teamviewer.com/en/develop/api/get-started/#createScript)

[Teamviewer Api Documentation](https://integrate.teamviewer.com/en/develop/api/)





