function Get-TeamviewerChoice 
{     
    [CmdletBinding()]
    Param
    (        
        [System.String]$Message = 'There were multiple matches', 
		
        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [System.String[]]$Choices, 
		
        [System.Int32]$DefaultChoice = 0, 
		
        [System.String]$Title = "Please Select a Device Name"
    )        
    
    Begin
    {

    }

    Process
    {
        Try
        {
            $ChoiceList = [System.Management.Automation.Host.ChoiceDescription[]] @($Choices)
            $Selection = $host.ui.PromptForChoice($Title, $Message, $ChoiceList, $DefaultChoice)
        }
        catch
        {
            throw $Error[0]
        }

        Return $Selection
    }

    End
    {

    }
}