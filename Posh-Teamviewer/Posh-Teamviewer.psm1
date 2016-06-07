$Public = @(Get-ChildItem -Path $PSScriptRoot\Public\*.ps1 -ErrorAction SilentlyContinue)
$Private = @(Get-ChildItem -Path $PSScriptRoot\Private\*.ps1 -ErrorAction SilentlyContinue)
$Script:ModuleRoot = $PSScriptRoot

Foreach ($import in @($Public + $Private))
{
	Try
	{
		. $import.fullname
	}
	Catch
	{
		Write-Error -Message "Failed to import function $($import.fullname): $_"
	}
}

# Removing Editor Commands until VS Code Supports SecureStrings
# if ($psEditor)
# {
#     Register-EditorCommand `
#         -Name "Posh-Teamviewer.ConnectDevice" `
#         -DisplayName "Connect to Teamviewer Device" `
#         -SuppressOutput `
#         -ScriptBlock {
#             param([Microsoft.PowerShell.EditorServices.Extensions.EditorContext]$context)
#             Connect-Teamviewer
#         }
        
#     Register-EditorCommand `
#         -Name "Posh-Teamviewer.SetDeviceList" `
#         -DisplayName "Set Teamviewer Device List Variable" `
#         -SuppressOutput `
#         -ScriptBlock {
#             param([Microsoft.PowerShell.EditorServices.Extensions.EditorContext]$context)
#             Set-TeamviewerDeviceList
#         }
    
#     Register-EditorCommand `
#         -Name "Posh-Teamviewer.InitializeTeamviewer" `
#         -DisplayName "Initialize Teamviewer" `
#         -SuppressOutput `
#         -ScriptBlock {
#             param([Microsoft.PowerShell.EditorServices.Extensions.EditorContext]$context)
#             Initialize-Teamviewer
#         }
# }

Export-ModuleMember -Function $Public.Basename