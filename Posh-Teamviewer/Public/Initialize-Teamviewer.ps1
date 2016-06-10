# .ExternalHelp Teamviewer-Help.xml
function Initialize-Teamviewer
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory=$true, ValueFromPipelineByPropertyName=$true, Position=0)]
        [securestring]$MasterPassword
    )

    Begin
    {        
        # Test if configuration file exists.                
        $TeamviewerConfigPath = Resolve-TeamviewerConfigPath        

        if (!(Test-Path "$($TeamviewerConfigPath)\api.key"))
        {
            throw 'Configuration has not been set, Set-TeamviewerAccessToken to configure the Access Token.'
        }
    }
    Process
    {
        Try
        {
            Write-Verbose -Message "Reading key from $($TeamviewerConfigPath)\api.key."
        
            $ConfigFileContent = Get-Content -Path "$($TeamviewerConfigPath)\api.key"
        
            Write-Debug -Message "Secure string is $($ConfigFileContent)"
        
            $SaltBytes = Get-Content -Encoding Byte -Path "$($TeamviewerConfigPath)\salt.rnd" 
            $Credentials = New-Object System.Management.Automation.PSCredential -ArgumentList 'user', $MasterPassword

            # Derive Key, IV and Salt from Key
            $Rfc2898Deriver = New-Object System.Security.Cryptography.Rfc2898DeriveBytes -ArgumentList $Credentials.GetNetworkCredential().Password, $SaltBytes, 10000
            $KeyBytes  = $Rfc2898Deriver.GetBytes(32)

            $SecString = ConvertTo-SecureString -Key $KeyBytes $ConfigFileContent

            # Decrypt the secure string.
            #$SecureStringToBSTR = [Runtime.InteropServices.Marshal]::SecureStringToBSTR($SecString)
            #$AccessToken = [Runtime.InteropServices.Marshal]::PtrToStringAuto($SecureStringToBSTR)

            # Set session variable with the Token.
            #$Global:TeamviewerAccessToken = $AccessToken
            $Global:TeamviewerAccessToken = $SecString
        
            Write-Verbose -Message 'Token has been set.'
        }
        Catch
        {
            Throw
        }
        Try
        {
            Write-Verbose -Message "Setting Device List"
            Set-TeamviewerDeviceList -AccessToken $AccessToken
        }
        Catch
        {
            Throw
        }
    }
    End
    {

    }
}