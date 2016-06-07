Import-Module Pester -ErrorAction Stop
Import-Module $PSScriptRoot\..\Posh-Teamviewer\Posh-TeamViewer.psd1

InModuleScope 'Posh-Teamviewer' {

    Describe 'Resolve-TeamviewerConfigPath' {
        
        Context 'Returns Config Directory' {

            It 'global variable should not be present' {
                $Results = Test-Path variable:Global:TeamviewerConfigPath
                $Results | Should be $false
            }

            $Results = Resolve-TeamviewerConfigPath

            It 'Should create global variable' {
                $PathResults = Test-Path variable:Global:TeamviewerConfigPath
                $PathResults | Should Be $true
            }

            It 'Should Return Directory' {                
                $Results | Should Be "$env:APPDATA\Teamviewer"
            }
        }        
    }
}