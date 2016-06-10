# .ExternalHelp Teamviewer-Help.xml
Function Set-TeamviewerDeviceList
{
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$false)]
        [securestring]$AccessToken
    )

    Begin
    {   
        Write-Verbose -Message 'Starting: Set Teamviewer Device List'
        
        if (!(Test-Path variable:Global:TeamviewerAccessToken ) -and !($AccessToken))
        {
            throw 'No Teamviewer Access Token has been specified or set. Use Set-TeamviewerAccessToken to set your AccessToken or Initialize-Teamviewer to load Teamviewer Global Variables.'
        }
        elseif ((Test-Path variable:Global:TeamviewerAccessToken ) -and !($AccessToken))
        {
            $AccessToken = $Global:TeamviewerAccessToken
        }

        $BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($AccessToken)
        $PlainAccessToken = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)     
    }

    Process
    {                
        $Headers = @{ 'Authorization' = "Bearer $PlainAccessToken" }
        $ContetType = 'application/json; charset=utf-8'
        $Uri = 'https://webapi.teamviewer.com/api/v1/devices/'
        
        Write-Verbose -Message "[GET] RestMethod: [$Uri]"                        

        $Result = Invoke-RestMethod -Method Get -Uri $Uri -Headers $Headers -ContentType $ContetType -ErrorVariable TVError -ErrorAction SilentlyContinue
            
        if ($TVError)
        {
            $JsonError = $TVError.Message | ConvertFrom-Json
            $HttpResponse = $TVError.ErrorRecord.Exception.Response
            Throw "Error: $($JsonError.error) `nDescription: $($JsonError.error_description) `nErrorCode: $($JsonError.error_code) `nHttp Status Code: $($HttpResponse.StatusCode.value__) `nHttp Description: $($HttpResponse.StatusDescription)"
        }
        else 
        {
            Write-Verbose -Message "Setting Device List to variable for use by other commands."

            $Global:TeamviewerDeviceList = $Result
        }
    }

    End
    {
    
    }
}