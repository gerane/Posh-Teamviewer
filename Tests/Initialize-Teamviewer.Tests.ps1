Import-Module Pester -ErrorAction Stop
Import-Module $PSScriptRoot\..\TeamViewer.psd1


InModuleScope 'Posh-Teamviewer' {

    Describe 'Initialize-Teamviewer' {
        $MasterPassword = ConvertTo-SecureString -String 'FakePassword' -AsPlainText -Force

        Context 'Sets Global AccessToken Variable' {
            Mock Resolve-TeamviewerConfigPath { Return ".\Files" }
            Mock Test-Path { Return $true }
            Mock Set-TeamviewerDeviceList {}

            It 'Global Access Token Should not match' {
                $Results = $Global:TeamviewerAccessToken
                $Results | Should Not Be 'Fake-AccessTokenText123456789'
            }

            Initialize-Teamviewer -MasterPassword $MasterPassword

            It 'Sets Global Access Token Variable' {
                $Results = $Global:TeamviewerAccessToken
                $Results | Should Be 'Fake-AccessTokenText123456789'
            }

            It 'Decrypts Apikey' {
                $Results = { Initialize-Teamviewer -MasterPassword $MasterPassword }
                $Results | Should Not Throw
            }
        }
    }
}