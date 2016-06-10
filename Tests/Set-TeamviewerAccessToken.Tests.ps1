Import-Module Pester -ErrorAction Stop
Import-Module $PSScriptRoot\..\Posh-Teamviewer\Posh-TeamViewer.psd1

InModuleScope 'Posh-Teamviewer' {

    Describe 'Set-TeamviewerAccessToken' {
        $AccessToken = ConvertTo-SecureString -String 'Fake-AccessTokenText123456789' -AsPlainText -Force
        $MasterPassword = ConvertTo-SecureString -String 'FakePassword' -AsPlainText -Force

        Context 'AppData Teamviewer Folder Exists' {
            Mock Test-Path { Return $true }
            Mock New-Item {}
            Mock Set-Content {}

            Set-TeamviewerAccessToken -AccessToken $AccessToken -MasterPassword $MasterPassword

            It 'Should not Create Directory' {
                Assert-MockCalled New-Item -Times 0
            }
        } 

        Context 'AppData Teamviewer Folder Missing' {
            Mock Test-Path { Return $false }
            Mock New-Item {}
            Mock Set-Content {}

            Set-TeamviewerAccessToken -AccessToken $AccessToken -MasterPassword $MasterPassword

            It 'Should Create Directory' {
                Assert-MockCalled New-Item -Times 1
            }            
        }
    
        Context 'Creates Access Token files in Folder' {
            $TestPath = Join-Path -Path 'TestDrive:\' -ChildPath 'Teamviewer'            
            Mock Resolve-TeamviewerConfigPath { Return $TestPath }            

            Set-TeamviewerAccessToken -AccessToken $AccessToken -MasterPassword $MasterPassword            

            It 'Should create api.key' {
                $Results = Test-Path "$TestPath\api.key"
                $Results | Should be $True 
            }

            It 'Should create salt.rnd' {
                $Results = Test-Path "$TestPath\salt.rnd"
                $Results | Should be $True
            }

            It 'Should Return False' {
                $Results = Test-Path -LiteralPath "$TestPath\Fake.txt" 
                $Results | Should be $False
            }
            
            It 'Salt should be 32 in length' {
                $Results = Get-item "$TestPath\salt.rnd"            
                $Results.length | Should be 32
            }
        }
    }    
}


