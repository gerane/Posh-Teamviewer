Import-Module Pester -ErrorAction Stop
Import-Module $PSScriptRoot\..\TeamViewer.psd1


InModuleScope 'Posh-Teamviewer' {

    Describe 'Get-TeamviewerChoice' {
        $Source = 'Get-TeamviewerChoice'

        Context '' {

        }
    }
}