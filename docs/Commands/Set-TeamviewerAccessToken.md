---
external help file: Posh-Teamviewer-help.xml
schema: 2.0.0
---

# Set-TeamviewerAccessToken
## SYNOPSIS
Encrypts the User's Teamviewer AccessToken and sets the value as a Global Variable.
## SYNTAX

```
Set-TeamviewerAccessToken -AccessToken <String> [-MasterPassword] <SecureString> [<CommonParameters>]
```

## DESCRIPTION
Encrypts the User's Teamviewer AccessToken with a Master Password and sets the value as `$Global:TeamviewerAccessToken Variable.
## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\> Set-TeamviewerAccessToken -AccessToken '1234-SWDwf23vawef4122345asfg' -MasterPassword $SecureString
```

Sets the AccessToken using the supplied Secure String Password.
### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\> Set-TeamviewerAccessToken -AccessToken '1234-SWDwf23vawef4122345asfg'
```

Prompts the User for their Master Password and sets the AccessToken.
## PARAMETERS

### -AccessToken
The Teamviewer Access Token.




```yaml
Type: String
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

[Online Version:](https://github.com/gerane/Posh-Teamviewer/blob/master/docs/Set-TeamviewerAccessToken.md)

[Carlos Perez Github](https://github.com/darkoperator)

[Create Teamviewer Access Token](https://integrate.teamviewer.com/en/develop/api/get-started/#createScript)

[Teamviewer Api Documentation:](https://integrate.teamviewer.com/en/develop/api/)





