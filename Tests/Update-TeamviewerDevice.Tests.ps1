Import-Module Pester -ErrorAction Stop
Import-Module $PSScriptRoot\..\Posh-Teamviewer\Posh-TeamViewer.psd1


InModuleScope 'Posh-Teamviewer' {

    Describe 'Update-TeamviewerDevice' {
        $AccessToken = ConvertTo-SecureString -String 'Fake-AccessTokenText123456789' -AsPlainText -Force
        $Password = 'FakePassword'

        Context 'Updates Device Description and Alias' {
            $MockedDeviceId = 'r123456789'
            $Description = 'Test Lab Device 1'
            $Alias = 'Test1 (Test Lab)'                            
            Mock Get-TeamviewerDeviceProperty { Return $MockedDeviceId } -Verifiable     
            Mock Set-TeamviewerDeviceList {}
            Mock Invoke-RestMethod { Return ($Body | ConvertFrom-Json) } -Verifiable
                        
            $Results = Update-TeamviewerDevice -ComputerName 'Test1' -Description $Description -Alias $Alias -AccessToken $AccessToken

            It 'Should Return Proper Json Description' {
                $Results.Description | Should Be $Description
            }

            It 'Should Return Proper Json Alias' {
                $Results.Alias | Should Be $Alias
            }

            It 'Should Not Set Device List' {
                Assert-MockCalled Set-TeamviewerDeviceList -Times 0
            }

            It "Should Assert Mocks" {
                Assert-VerifiableMocks
            }

            It 'Should Return DeviceId' {
                Get-TeamviewerDeviceProperty -ComputerName 'Test1' | Should Be $MockedDeviceId
            }
        }

        Context 'Updates Password with Update Switch' {
            $MockedDeviceId = 'r123456789'                   
            Mock Get-TeamviewerDeviceProperty { Return $MockedDeviceId } -Verifiable              
            Mock Set-TeamviewerDeviceList {} -Verifiable
            Mock Invoke-RestMethod { Return ($Body | ConvertFrom-Json) } -Verifiable

            $Results = Update-TeamviewerDevice -ComputerName 'Test1' -Password $Password -AccessToken $AccessToken -UpdateDeviceList

            It 'Should Return Proper Json Password' {
                $Results.Password | Should Be $Password
            }

            It 'Should Set Device List' {
                Assert-MockCalled Set-TeamviewerDeviceList -Times 1
            }

            It "Should Assert Mocks" {
                Assert-VerifiableMocks
            }

            It 'Should Return DeviceId' {
                Get-TeamviewerDeviceProperty -ComputerName 'Test1' | Should Be $MockedDeviceId
            }
        }

        Context 'Rest-Method Returns an Error' {
            $MockedDeviceId = 'r123456789'   
            Mock Get-TeamviewerDeviceProperty { Return $MockedDeviceId } -Verifiable
            Mock ConvertFrom-Json {} -Verifiable
            Mock Invoke-RestMethod { Get-Content -Path .\Fakepath.txt -ErrorVariable TVError -ErrorAction SilentlyContinue } -Verifiable

            It 'Should Throw TVError' {
                $Results = { Update-TeamviewerDevice -ComputerName 'Test1' -Password $Password -AccessToken $AccessToken }
                $Results | Should Throw
            }

            It 'Should Assert Mocks' {
                Assert-VerifiableMocks
            }
        }
    }
}