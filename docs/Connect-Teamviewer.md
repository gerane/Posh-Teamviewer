---
external help file: Posh-Teamviewer-help.xml
schema: 2.0.0
---

# Connect-Teamviewer
## SYNOPSIS
Connects to a Teamviewer Device
## SYNTAX

### List
```
Connect-Teamviewer -ComputerName <String[]> -Password <SecureString> [<CommonParameters>]
```

### Update
```
Connect-Teamviewer -ComputerName <String[]> -Password <SecureString> [-UpdateDeviceList] [-AccessToken <String>]
 [<CommonParameters>]
```

## DESCRIPTION
Connects to a Teamviewer Device using ComputerName.

Requires a Teamviewer Access Token to be set via Set-TeamviewerAccessToken. If in a new PowerShell Session, you can load a saved Access Token with Initialize-Teamviewer.
## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\> Connect-Teamviewer -ComputerName 'TestName' -Password $SecureString
```

Connects to Teamviewer device using supplied password as Secure String. 
### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\> Connect-Teamviewer -ComputerName 'TestName'
```

Connects to Teamviewer device and prompts the User to enter the Device Password.
### -------------------------- EXAMPLE 3 --------------------------
```
PS C:\> $ComputerList = @('Test1','Test2')
PS C:\> Connect-Teamviewer -ComputerName $ComputerList
```

Connects to Teamviewer devices Test1 and Test2 and prompts the User to enter the Device Password. 
### -------------------------- EXAMPLE 4 --------------------------
```
PS C:\> Connect-Teamviewer -ComputerName 'Test'
```

The user is prompted to select a Device from a list of Matches of Devices with the word 'Test' in the name.
### -------------------------- EXAMPLE 5 --------------------------
```
PS C:\> Connect-Teamviewer -ComputerName 'TestName' -UpdateDeviceList
```

Updates the stored Device list before connecting to the Device. Requires the Teamviewer AccessToken to be set using Set-TeamviewerAccessToken or Initialize-Teamviewer to load a previously saved one.
## PARAMETERS

### -AccessToken
The Teamviewer Access Token.



```yaml
Type: String
Parameter Sets: Update
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -ComputerName
The name or the alias of the Device to be connected to.



```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: True
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -Password
The Teamviewer Device password.



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

### -UpdateDeviceList
Update the Devices List Global Variable that the Device information is stored. Teamviewer accounts with a large device list can take a very long time to send a response back with Device Ids. To get around this Device information is gathered and stored when Initialize-Teamviewer is ran to decrypt the Teamviewer Access Token. This allows quick Device information look up. If the information needs to be updated you can either add this switch.



```yaml
Type: SwitchParameter
Parameter Sets: Update
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).
## INPUTS

### System.String[]

## OUTPUTS

### System.Object

## NOTES
Before you can use this Command you need to set you Teamviewer AccessToken with Set-TeamviewerAccessToken or load a previously saved AccessToken with Initialize-Teamviewer.
## RELATED LINKS

[Online Version:](https://github.com/gerane/Posh-Teamviewer/blob/master/docs/Connect-Teamviewer.md)

Initialize-Teamviewer

Set-TeamviewerAccessToken

Update-TeamviewerDeviceList

Set-TeamviewerDeviceList

[Create Teamviewer Access Token](https://integrate.teamviewer.com/en/develop/api/get-started/#createScript)

[Teamviewer Api Documentation:](https://integrate.teamviewer.com/en/develop/api/)




