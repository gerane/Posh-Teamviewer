# .ExternalHelp Teamviewer-Help.xml
function Connect-Teamviewer
{
    [CmdletBinding(DefaultParameterSetName = 'List')]
    param
    (        
        [Parameter(ParameterSetName = 'List', Mandatory=$true)]
        [Parameter(ParameterSetName = 'Update', Mandatory=$true)]
        [string[]]$ComputerName,
        
        [Parameter(ParameterSetName = 'List', Mandatory=$true)]
        [Parameter(ParameterSetName = 'Update', Mandatory=$true)]
        [securestring]$Password,
        
        [Parameter(ParameterSetName = 'Update', Mandatory=$false)]
        [Switch]$UpdateDeviceList,

        [Parameter(ParameterSetName = 'Update', Mandatory=$false)]
        [securestring]$AccessToken
    )

    Begin
    {   
        Write-Verbose -Message 'Starting: Connect to Teamviewer Device'

        if ($PSBoundParameters.ContainsKey('UpdateDeviceList'))
        {
            if (!(Test-Path variable:Global:TeamviewerAccessToken ) -and !($AccessToken))
            {
                throw 'No Teamviewer Access Token has been specified or set. Use Set-TeamviewerAccessToken to set your AccessToken or Initialize-Teamviewer to load Teamviewer Global Variables.'
            }
            elseif ((Test-Path variable:Global:TeamviewerAccessToken ) -and !($AccessToken))
            {
                $AccessToken = $Global:TeamviewerAccessToken
            }  

            Write-Verbose -Message "Updating Teamviewer Device List before Connecting to Device"
            Set-TeamviewerDeviceList -AccessToken $AccessToken
        }

        $BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($Password)
        $PlainPassword = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)
    }
    
    Process
    {
        [ValidateNotNullOrEmpty()]$Teamviewer = Get-ChildItem -Path "$Env:SystemDrive\Program File*\Teamviewer\Teamviewer.exe" -Recurse | Select-Object -ExpandProperty fullname

        Write-Verbose -Message "Teamviewer Exe Path: [$Teamviewer]"
        
        foreach ($Name in $ComputerName)
        {                    
            Try
            {
                $RemoteId = (Get-TeamviewerDeviceProperty -ComputerName $Name -remotecontrol_id).substring(1)
                Write-Verbose -Message "Connecting to ComputerName: [$Name] with Teamviewer ID: [$RemoteId]"

                Start-Process -FilePath $Teamviewer -ArgumentList "-i $RemoteId --Password $PlainPassword" -ErrorAction Stop -WindowStyle Maximized             
            }
            catch
            {
                Throw "Failed to Connect to ComputerName: [$Name] using Teamviewer ID: [$RemoteId]"
            }        
        }
    }

    End 
    {
    
    }
}
