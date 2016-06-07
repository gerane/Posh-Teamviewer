function Resolve-TeamviewerConfigPath
{
    [CmdletBinding()]
    param()

    Begin
    {

    }

    Process
    {
        Write-Verbose -Message 'Resolving Teamviewer Config Path'
        $Global:TeamviewerConfigPath = "$env:APPDATA\Teamviewer"

        Write-Verbose -Message "Teamviewer Config Path: $($Global:TeamviewerConfigPath)"
        Return $Global:TeamviewerConfigPath
    }

    End
    {

    }
}