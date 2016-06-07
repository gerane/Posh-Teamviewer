# .ExternalHelp Teamviewer-Help.xml
Function Update-TeamviewerDevice
{
    [CmdletBinding()]
    param
    (        
        [Parameter(Mandatory=$true, ValueFromPipelineByPropertyName=$true)]
        [string]$ComputerName,
        
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [string]$Description,
        
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [string]$Alias,
        
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [string]$Password,
        
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Switch]$UpdateDeviceList,

        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$false)]
        [string]$AccessToken
    )

    Begin
    {   
        Write-Verbose -Message 'Starting: Update Teamviewer Device'
        
        if (!(Test-Path variable:Global:TeamviewerAccessToken ) -and !($AccessToken))
        {
            throw 'No Teamviewer Access Token has been specified or set. Use Set-TeamviewerAccessToken to set your AccessToken or Initialize-Teamviewer to load Teamviewer Global Variables.'
        }
        elseif ((Test-Path variable:Global:TeamviewerAccessToken ) -and !($AccessToken))
        {
            $AccessToken = $Global:TeamviewerAccessToken
        }  

        if ($PSBoundParameters.ContainsKey('UpdateDeviceList'))
        {
            Write-Verbose -Message "Updating Teamviewer Device List before Updating Device"
            Set-TeamviewerDeviceList
        }
    }

    Process
    {
        Write-Verbose "Changing Device Information: [$ComputerName]"
        
        Try
        {
            Write-Verbose -Message "Getting the Device ID for [$ComputerName]"
            $deviceId = Get-TeamviewerDeviceProperty -ComputerName $ComputerName -device_id
        }
        catch
        {
            Throw $Error[0]
        }

        $Headers = @{ 'Authorization' = "Bearer $AccessToken" }
        $ContetType = 'application/json; charset=utf-8'
        $Uri = 'https://webapi.teamviewer.com/api/v1/devices/' + $deviceId
        
        Write-Verbose -Message "[PUT] RestMethod: [$Uri]"

        $deviceFields = @{}
        
        if ($PSBoundParameters.ContainsKey('Description')) 
        { 
            Write-Verbose -Message "Adding Description Field: [$Description]"
            $deviceFields.description = $Description 
        }
        
        if ($PSBoundParameters.ContainsKey('Password')) 
        { 
            Write-Verbose -Message "Adding Password Field: [$Password]"
            $deviceFields.password = $Password 
        }
    
        if ($PSBoundParameters.ContainsKey('Alias')) 
        { 
            Write-Verbose -Message "Adding Alias Field: [$Alias]"
            $deviceFields.alias = $Alias
        }

        $psobject = New-Object psobject -Property $deviceFields
        $Body = $psobject | Microsoft.PowerShell.Utility\ConvertTo-Json
		
        Write-Verbose -Message "Body: $($Body)"

        Invoke-RestMethod -Method Put -Uri $Uri -Headers $Headers -ContentType $ContetType -Body $Body -ErrorVariable TVError -ErrorAction SilentlyContinue
        
        if ($TVError)
        {
            $JsonError = $TVError.Message | ConvertFrom-Json
            $HttpResponse = $TVError.ErrorRecord.Exception.Response
            Throw "Error: $($JsonError.error) `nDescription: $($JsonError.error_description) `nErrorCode: $($JsonError.error_code) `nHttp Status Code: $($HttpResponse.StatusCode.value__) `nHttp Description: $($HttpResponse.StatusDescription)"
        }
    }

    End
    {

    }
}