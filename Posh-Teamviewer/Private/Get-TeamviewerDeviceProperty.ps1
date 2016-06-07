function Get-TeamviewerDeviceProperty
{
    [CmdletBinding(DefaultParameterSetName = 'remotecontrol_id')]
    param
    (        
        [Parameter(Mandatory=$true)]
        [string]$ComputerName,

        [Parameter(ParameterSetName = 'device_id')]
        [switch]$device_id,

        [Parameter(ParameterSetName = 'remotecontrol_id')]
        [switch]$remotecontrol_id,

        [Parameter(ParameterSetName = 'description')]
        [switch]$description

    )

    Begin 
    {
        Write-Verbose -Message 'Starting: Get Teamviewer Device Property'
        
        if (!(Test-Path variable:Global:TeamviewerDeviceList ) -and !($DeviceList))
        {
            throw 'No Teamviewer Access Token has been specified or set. Use Set-TeamviewerAccessToken to set your AccessToken or Initialize-Teamviewer to load Teamviewer Global Variables.'
        }
        elseif ((Test-Path variable:Global:TeamviewerDeviceList ) -and !($DeviceList))
        {
            $DeviceList = $Global:TeamviewerDeviceList
        } 
    }

    Process
    {
        $Property = $PSCmdlet.ParameterSetName
        Write-Verbose -Message "Device Property: [$($Property)]"
       
        $Devices = $DeviceList.devices | Where-Object { $_.'alias' -like "*$ComputerName*" }
        
        if ($Devices.count -eq 0)
        {
            Throw "No Device found for [$ComputerName]"
        }
        elseif ($Devices.count -gt '1')
        {
            Write-Verbose -Message "Multiple Names Matched, Prompting User for selection."

            $Selection = Get-TeamviewerChoice -Choices $Devices.alias
            $Device = $Devices[$Selection]

            $DeviceProperty = $Device.$Property
        }
        else
        {
            $DeviceProperty = $Devices.$Property
        }
        Write-Verbose -Message "Device [$($Property)] is [$($DeviceProperty)]"
    
        Return $DeviceProperty
    }

    End
    {
        
    }
}