Import-Module Pester -ErrorAction Stop
Import-Module $PSScriptRoot\..\Posh-Teamviewer\Posh-TeamViewer.psd1

$Json = @"
{  
    "devices":[  
        {  
            "remotecontrol_id":"r123456789",
            "device_id":"d12345678",
            "alias":"Device1",
            "groupid":"g1234567",
            "online_state":"Online",
            "supported_features":"remote_control, chat",
            "description":"Test Device 1"
        },
        {  
            "remotecontrol_id":"r987654321",
            "device_id":"d87654321",
            "alias":"Device2",
            "groupid":"g7654321",
            "online_state":"Offline",
            "supported_features":"chat",
            "description":"Test Device 2"
        },
        {  
            "remotecontrol_id":"r987612345",
            "device_id":"d87612345",
            "alias":"Device3",
            "groupid":"g7612345",
            "online_state":"Online",
            "supported_features":"remote_control",
            "description":"Test Device 3"
        }
    ]
}
"@

$MockedResults = $Json | ConvertFrom-Json

$Global:TeamviewerAccessToken = $null

InModuleScope 'Posh-Teamviewer' {

    Describe 'Set-TeamviewerDeviceList' {
        $AccessToken = ConvertTo-SecureString -String 'Fake-AccessTokenText123456789' -AsPlainText -Force

        Context 'Sets Global Variable' {
            Mock Invoke-RestMethod { Return $MockedResults }
            
            It 'Global Access Token Should not match' {
                $Results = $Global:TeamviewerAccessToken
                $Results | Should Not Be $AccessToken
            }

            $Results = Set-TeamviewerDeviceList -AccessToken $AccessToken

            It 'Should create global variable' {
                $PathResults = Test-Path variable:Global:TeamviewerDeviceList
                $PathResults | Should Be $true
            }

            It 'Should not throw' {
                $Results = { Set-TeamviewerDeviceList -AccessToken $AccessToken }
                $Results | Should Not Throw
            }
        }

        Context 'Rest-Method Returns an Error' {
            Mock ConvertFrom-Json {}
            Mock Invoke-RestMethod { Get-Content -Path .\Fakepath.txt -ErrorVariable TVError }

            It 'Should Throw TVError' {
                $Results = { Set-TeamviewerDeviceList -AccessToken $AccessToken }
                $Results | Should Throw
            }
        }
    }
}