Import-Module Pester -ErrorAction Stop
Import-Module $PSScriptRoot\..\Posh-Teamviewer\Posh-TeamViewer.psd1


InModuleScope 'Posh-Teamviewer' {

    Describe 'Connect-Teamviewer' {
        $AccessToken = ConvertTo-SecureString -String 'Fake-AccessTokenText123456789' -AsPlainText -Force
        $Password = ConvertTo-SecureString -String 'FakePassword' -AsPlainText -Force

        Context 'No Teamviewer Exe Found' {
            $MockedRemoteId = 'r123456789'
            Mock Get-ChildItem { Return [PSCustomObject]@{FullName="C:\Fake\Path.exe"} } -Verifiable
            Mock Select-Object {}           
            Mock Get-TeamviewerDeviceProperty {}
            Mock Start-Process {}

            It 'Should Fail Variable Validation' {
                $Results = { Connect-Teamviewer -ComputerName 'Test1' -Password $Password -AccessToken $AccessToken }
                $Results | Should Throw
            }
        }

        Context 'Connects to Device without Update Switch' {
            $MockedRemoteId = 'r123456789'
            Mock Get-ChildItem { Return [PSCustomObject]@{FullName="C:\Fake\Path.exe"} } -Verifiable            
            Mock Get-TeamviewerDeviceProperty { Return $MockedRemoteId } -Verifiable
            Mock Start-Process { Return $RemoteId } -Verifiable
            Mock Set-TeamviewerDeviceList {}

            It 'Return Proper Remote ID' {
                $Results = Connect-Teamviewer -ComputerName 'TestName' -Password $Password -AccessToken $AccessToken
                $Results | Should Be $MockedRemoteId.substring(1)
            }

            It "Should Assert Mocks" {
                Assert-VerifiableMocks
            }

            It 'Should Not Set Device List' {
                Assert-MockCalled Set-TeamviewerDeviceList -Times 0
            }
        }

        Context 'Connects to Device with Update Switch' {
            $MockedRemoteId = 'r123456789'
            Mock Get-ChildItem { Return [PSCustomObject]@{FullName="C:\Fake\Path.exe"} } -Verifiable            
            Mock Get-TeamviewerDeviceProperty { Return $MockedRemoteId } -Verifiable
            Mock Start-Process { Return $RemoteId } -Verifiable
            Mock Set-TeamviewerDeviceList {} -Verifiable

            It 'Return Proper Remote ID' {
                $Results = Connect-Teamviewer -ComputerName 'Test1' -Password $Password -AccessToken $AccessToken -UpdateDeviceList
                $Results | Should Be $MockedRemoteId.substring(1)
            }

            It "Should Assert Mocks" {
                Assert-VerifiableMocks
            }
        }
    }
}