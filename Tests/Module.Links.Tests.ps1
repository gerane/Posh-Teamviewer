#TODO: Convert to PoshSpec

$Links = @()
$MarkdownLinks = Get-ChildItem $PSScriptRoot\..\* -Include '*.md' -Recurse | Select-String '^.*\[.*\]\((http.*)\).*$' -AllMatches
foreach ($Match in $MarkdownLinks)
{
    $Links += $Match.Matches.Groups.value[1]
}

$Links = $Links | Sort-Object -Unique

Describe "Testing Resources" {
    
    Context "Links are working" {
        
        foreach ($Link in $Links)
        {
            It "[$($Link)] should have 200 Status Code" {

                $Results = Invoke-WebRequest -Uri $Link -UseBasicParsing
                $Results.StatusCode | Should Be '200'
            }
        }
    }
}