Task default -depends Build

Properties {
    Set-BuildEnvironment

    $ProjectRoot = $ENV:BHProjectPath
    $ProjectName = $ENV:BHProjectName
    
    if(-not $ProjectRoot) { [ValidateNotNullOrEmpty()]$ProjectRoot = $Psake.build_script_dir }
    if(-not $ProjectName) { [ValidateNotNullOrEmpty()]$ProjectName = (Get-Item $PSScriptRoot\*.psd1)[0].BaseName }
    
    $Timestamp = Get-date -uformat "%Y%m%d-%H%M%S"
    $PSVersion = $PSVersionTable.PSVersion.Major
    $TestFile = "TestResults_PS$PSVersion`_$TimeStamp.xml"
    $lines = '----------------------------------------------------------------------'

    $Verbose = @{}
    if ($ENV:BHCommitMessage -match "!verbose")
    {
        $Verbose = @{Verbose = $True}
    }
}


Task Init {
    $lines
    Set-Location $ProjectRoot
    "Build System Details:"
    Get-Item ENV:BH*
    "`n"
}


Task Help -depends Init {
    Remove-Module $ProjectName -ErrorAction SilentlyContinue
    Import-Module "$ProjectRoot\$ProjectName\$ProjectName.psd1"
    
    Try
    {
        New-ExternalHelp docs -OutputPath "$ProjectName\en-US" -Force -ErrorAction Stop
    }
    Catch
    {
        Throw
    }
    
    Import-Module "$ProjectRoot\$ProjectName\$ProjectName.psd1" -Force
}


Task Test -depends Help {
    $lines
    "`n`tSTATUS: Testing with PowerShell $PSVersion"

    # Gather test results. Store them in a variable and file
    $TestResults = Invoke-Pester -Path $ProjectRoot\Tests -PassThru -PesterOption @{IncludeVSCodeMarker=$true} -OutputFormat NUnitXml -OutputFile "$ProjectRoot\$TestFile"
    
    # In Appveyor?  Upload our tests! #Abstract this into a function?
    If($ENV:BHBuildSystem -eq 'AppVeyor')
    {
        (New-Object 'System.Net.WebClient').UploadFile("https://ci.appveyor.com/api/testresults/nunit/$($env:APPVEYOR_JOB_ID)","$ProjectRoot\$TestFile" )
    }

    Remove-Item "$ProjectRoot\$TestFile" -Force -ErrorAction SilentlyContinue

    if ($TestResults.FailedCount -gt 0)
    {
        Write-Error "Failed '$($TestResults.FailedCount)' tests, build failed"
    }
    "`n"
}


Task Build -depends Test {
    $lines
    
    $Params = @{
        Path = $ProjectRoot
        Tags = Local
        Force = $true            
    }

    Invoke-PSDeploy @Verbose @Params
}


Task Deploy -Depends Build {
    $lines

    # Gate deployment
    if ($ENV:BHBuildSystem -ne 'Unknown' -and $ENV:BHBranchName -eq "master" -and $ENV:BHCommitMessage -match '!deploy')
    {
        $Params = @{
            Path = $ProjectRoot
            Force = $true
            Tags = PSGallery
            Recurse = $false # We keep psdeploy artifacts, avoid deploying those : )
        }

        Invoke-PSDeploy @Verbose @Params
    }
    else
    {
        "Skipping deployment: To deploy, ensure that...`n" +
        "`t* You are in a known build system (Current: $ENV:BHBuildSystem)`n" +
        "`t* You are committing to the master branch (Current: $ENV:BHBranchName) `n" +
        "`t* Your commit message includes !deploy (Current: $ENV:BHCommitMessage)"
    }
}


Task ? -description 'Lists the available tasks' {
    "Available tasks:"
    $psake.context.Peek().tasks.Keys | Sort
}



function Get-NuGetApiKey
{
    param 
    (
        [parameter(Mandatory=$false)]
        [string]$NuGetApiKey,

        [parameter(Mandatory=$true)]
        [ValidateNotNull()]
        [string]$EncryptedApiKeyPath
    )

    Process
    {
        $NuGetConfigPath = Split-Path -Path $EncryptedApiKeyPath -Parent
        
        if (!$PSBoundParameters.ContainsKey('NuGetApiKey'))
        {
            $StoredApiKey = $null            
            
            If (Test-Path -Path $EncryptedApiKeyPath)
            {
                Write-Verbose -Message "Importing Encrypted NuGet ApiKey"
                
                $StoredApiKey = Get-Content -Path $EncryptedApiKeyPath                
                $SaltBytes = Get-Content -Encoding Byte -Path "$($NuGetConfigPath)\salt.rnd"
                
                $Credentials = Get-Credential -UserName user -Message 'NuGet ApiKey Password'
                
                $Rfc2898Deriver = New-Object System.Security.Cryptography.Rfc2898DeriveBytes -ArgumentList $Credentials.GetNetworkCredential().Password, $SaltBytes, 10000
                $KeyBytes  = $Rfc2898Deriver.GetBytes(32)

                $SecString = ConvertTo-SecureString -Key $KeyBytes $StoredApiKey

                # Decrypt the secure string.
                $SecureStringToBSTR = [Runtime.InteropServices.Marshal]::SecureStringToBSTR($SecString)
                $NuGetApiKey = [Runtime.InteropServices.Marshal]::PtrToStringAuto($SecureStringToBSTR)
            }
            else 
            {
                $NewApiKey = Get-Credential -Message "Enter your NuGet API Key in the password field (or nothing, this isn't used yet in the preview)" -UserName "NuGet ApiKey"
                $NuGetApiKey = $NewApiKey.GetNetworkCredential().Password
            }
        }

        if (!$StoredApiKey)
        {
            $SecureKeyString = ConvertTo-SecureString -String $NuGetApiKey -AsPlainText -Force    

            # Generate a random secure Salt
            $SaltBytes = New-Object byte[] 32
            $RNG = New-Object System.Security.Cryptography.RNGCryptoServiceProvider
            $RNG.GetBytes($SaltBytes)

            $Credentials = Get-Credential -UserName user -Message 'NuGet ApiKey Password'

            # Derive Key, IV and Salt from Key
            $Rfc2898Deriver = New-Object System.Security.Cryptography.Rfc2898DeriveBytes -ArgumentList $Credentials.GetNetworkCredential().Password, $SaltBytes, 10000
            $KeyBytes  = $Rfc2898Deriver.GetBytes(32)

            $EncryptedString = $SecureKeyString | ConvertFrom-SecureString -key $KeyBytes
        
        
            if (!(Test-Path -Path $NuGetConfigPath))
            {
                Write-Verbose -Message 'Seems this is the first time the config has been set.'
                Write-Verbose -Message "Creating folder $($NuGetConfigPath)"

                $Null = New-Item -ItemType directory -Path $NuGetConfigPath
            }

            Write-Verbose -Message "Saving the information to configuration file $($EncryptedApiKeyPath)"

            "$($EncryptedString)"  | Set-Content  "$($EncryptedApiKeyPath)" -Force

            # Saving salt in to the file.
            Set-Content -Value $SaltBytes -Encoding Byte -Path "$($NuGetConfigPath)\salt.rnd" -Force
        }

        Write-Verbose -Message "Setting Variable: Global:NuGetApiKey"
        $Global:NuGetApiKey = $NugetApiKey
        
        Return $NuGetApiKey
    }
}
