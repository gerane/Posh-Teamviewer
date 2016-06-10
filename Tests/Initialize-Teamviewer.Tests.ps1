Import-Module Pester -ErrorAction Stop
Import-Module $PSScriptRoot\..\Posh-Teamviewer\Posh-TeamViewer.psd1

$Global:TeamviewerAccessToken = $null

InModuleScope 'Posh-Teamviewer' {

    Describe 'Initialize-Teamviewer' {        
        $MasterPassword = ConvertTo-SecureString -String 'FakePassword' -AsPlainText -Force

        Context 'Sets Global AccessToken Variable' {
            Mock Resolve-TeamviewerConfigPath { Return (Resolve-Path "$Script:ModuleRoot\..\Tests\Files") }
            Mock Test-Path { Return $true }
            Mock Set-TeamviewerDeviceList {}

            It 'Global Access Token Should not match' {
                $Results = $Global:TeamviewerAccessToken
                $Results | Should Be $Null
            }

            Initialize-Teamviewer -MasterPassword $MasterPassword

            It 'Sets Global Access Token Variable' {
                $Results = Test-Path variable:Global:TeamviewerDeviceList
                $Results | Should Be $true
            }

            It 'Decrypts Apikey' {
                $Results = { Initialize-Teamviewer -MasterPassword $MasterPassword }
                $Results | Should Not Throw
            }
        }
    }
}