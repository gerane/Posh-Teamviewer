Task default -depends Deploy

Properties {
    Set-BuildEnvironment
    $ErrorActionPreference = 'Stop'

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
    Set-Location $ProjectRoot
    "$lines`nBuild System Details:"
    
    Get-Item ENV:BH*
    "`n"
}


Task Analyze -depends Init {    
    "$lines`n`n`tSTATUS: Scanning for PSScriptAnalyzer Errors"

    $ScanResults = Invoke-ScriptAnalyzer -Path "$ProjectRoot\$ProjectName" -Recurse -Severity Error

    If ($ScanResults.count -gt 0)
    {
        Throw "Failed PSScriptAnalyzer Tests"
    }
}


Task Help -depends Analyze {    
    "$lines`n`n`tSTATUS: Building Module Help"
    
    Remove-Module $ProjectName -ErrorAction SilentlyContinue		
    Import-Module "$ProjectRoot\$ProjectName\$ProjectName.psd1"		
      		      
    Try
    {
          New-ExternalHelp 'docs\Commands' -OutputPath "$ProjectName\en-US" -Force -ErrorAction Stop
          Import-Module "$ProjectRoot\$ProjectName\$ProjectName.psd1" -Force
    }
    Catch
    {
        Throw
    }        
}


Task Test -depends Help {
    "$lines`n`n`tSTATUS: Testing with PowerShell $PSVersion"
           
    $TestResults = Invoke-Pester -Path $ProjectRoot\Tests -PassThru -PesterOption @{IncludeVSCodeMarker=$true} -OutputFormat NUnitXml -OutputFile "$ProjectRoot\$TestFile" -EnableExit -Strict

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
    
    if ($ENV:BHBuildSystem -eq 'Unknown')
    {
        "$lines`n`n`tSTATUS: Building Local Module"

        Try 
        { 
            Invoke-PSDeploy @Verbose -Tags Local -Force 
        }
        Catch 
        { 
            Throw 
        }
    } 
}


Task Deploy -Depends Build {
    
    if ($ENV:BHBuildSystem -ne 'Unknown' -and $ENV:BHBranchName -eq "master" -and $ENV:BHCommitMessage -match '!deploy')
    {   
        "$lines`n`n`tSTATUS: Publishing to PSGallery"

        Try
        {
            Invoke-PSDeploy @Verbose -Force -Tags 'PSGallery'
        }
        Catch
        {
            Throw
        }
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