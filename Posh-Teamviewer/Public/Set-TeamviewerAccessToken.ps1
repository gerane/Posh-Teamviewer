# .ExternalHelp Teamviewer-Help.xml
function Set-TeamviewerAccessToken
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory=$true)]
        [securestring]$AccessToken,

        [Parameter(Mandatory=$true, ValueFromPipelineByPropertyName=$true, Position=1)]
        [securestring]$MasterPassword
    )

    Begin
    {
        $TeamviewerConfigPath = Resolve-TeamviewerConfigPath
    }
    
    Process
    {
        #$Global:TeamviewerAccessToken = $AccessToken
        #$SecureKeyString = ConvertTo-SecureString -String $AccessToken -AsPlainText -Force
        $SecureKeyString = $AccessToken

        # Generate a random secure Salt
        $SaltBytes = New-Object byte[] 32
        $RNG = New-Object System.Security.Cryptography.RNGCryptoServiceProvider
        $RNG.GetBytes($SaltBytes)

        $Credentials = New-Object System.Management.Automation.PSCredential -ArgumentList 'user', $MasterPassword

        # Derive Key, IV and Salt from Key
        $Rfc2898Deriver = New-Object System.Security.Cryptography.Rfc2898DeriveBytes -ArgumentList $Credentials.GetNetworkCredential().Password, $SaltBytes, 10000
        $KeyBytes  = $Rfc2898Deriver.GetBytes(32)

        $EncryptedString = $SecureKeyString | ConvertFrom-SecureString -key $KeyBytes
        
        $ConfigName = 'api.key'
        $saltname   = 'salt.rnd'
        
        if (!(Test-Path -Path "$($TeamviewerConfigPath)"))
        {
            Write-Verbose -Message 'Seems this is the first time the config has been set.'
            Write-Verbose -Message "Creating folder $($TeamviewerConfigPath)"
            
            New-Item -ItemType directory -Path "$($TeamviewerConfigPath)" | Out-Null
        }
        
        Write-Verbose -Message "Saving the information to configuration file $("$($TeamviewerConfigPath)\$ConfigName")"
        
        "$($EncryptedString)"  | Set-Content  "$($TeamviewerConfigPath)\$ConfigName" -Force

        # Saving salt in to the file.
        Set-Content -Value $SaltBytes -Encoding Byte -Path "$($TeamviewerConfigPath)\$saltname" -Force
    }
    End
    {
        
    }
}