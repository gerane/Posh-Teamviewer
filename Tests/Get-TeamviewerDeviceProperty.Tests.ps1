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

$Global:TeamviewerDeviceList = $Json | ConvertFrom-Json

InModuleScope 'Posh-Teamviewer' {

    Describe 'Get-TeamviewerDeviceProperty' {          

        Context 'Device_id' {
            Mock Get-TeamviewerChoice { Return 0 }

            It 'Throw because Device not found' {
                $Results = { Get-TeamviewerDeviceProperty -ComputerName 'Device4' -device_id }
                $Results | Should Throw
            }

            It 'Should Return Device1 Device_id' {
                $Results = Get-TeamviewerDeviceProperty -ComputerName 'Device1' -device_id
                $Results | Should Be 'd12345678'
            }

            It 'Should Return Device2 Device_id' {
                $Results = Get-TeamviewerDeviceProperty -ComputerName 'Device2' -device_id
                $Results | Should Be 'd87654321'
            }

            It 'Should Return Device3 Device_id' {
                $Results = Get-TeamviewerDeviceProperty -ComputerName 'Device3' -device_id
                $Results | Should Be 'd87612345'
            }

            It 'Should Return Device1 Device_id from Choice' {
                $Results = Get-TeamviewerDeviceProperty -ComputerName 'Device' -device_id
                $Results | Should Be 'd12345678'
            }
        }

        Context 'remotecontrol_id' {
            Mock Get-TeamviewerChoice { Return 1 }

            It 'Throw because Device not found' {
                $Results = { Get-TeamviewerDeviceProperty -ComputerName 'Device4' -remotecontrol_id }
                $Results | Should Throw
            }

            It 'Should Return Device1 remotecontrol_id' {
                $Results = Get-TeamviewerDeviceProperty -ComputerName 'Device1' -remotecontrol_id
                $Results | Should Be 'r123456789'
            }

            It 'Should Return Device2 remotecontrol_id' {
                $Results = Get-TeamviewerDeviceProperty -ComputerName 'Device2' -remotecontrol_id
                $Results | Should Be 'r987654321'
            }

            It 'Should Return Device3 remotecontrol_id' {
                $Results = Get-TeamviewerDeviceProperty -ComputerName 'Device3' -remotecontrol_id
                $Results | Should Be 'r987612345'
            }

            It 'Should Return Device1 remotecontrol_id from Choice' {
                $Results = Get-TeamviewerDeviceProperty -ComputerName 'Device' -remotecontrol_id
                $Results | Should Be 'r987654321'
            }
        }

        Context 'description' {
            Mock Get-TeamviewerChoice { Return 2 }

            It 'Throw because Device not found' {
                $Results = { Get-TeamviewerDeviceProperty -ComputerName 'Device4' -description }
                $Results | Should Throw
            }

            It 'Should Return Device1 description' {
                $Results = Get-TeamviewerDeviceProperty -ComputerName 'Device1' -description
                $Results | Should Be 'Test Device 1'
            }

            It 'Should Return Device2 description' {
                $Results = Get-TeamviewerDeviceProperty -ComputerName 'Device2' -description
                $Results | Should Be 'Test Device 2'
            }

            It 'Should Return Device3 description' {
                $Results = Get-TeamviewerDeviceProperty -ComputerName 'Device3' -description
                $Results | Should Be 'Test Device 3'
            }

            It 'Should Return Device1 description from Choice' {
                $Results = Get-TeamviewerDeviceProperty -ComputerName 'Device' -description
                $Results | Should Be 'Test Device 3'
            }
        }
    }
}
