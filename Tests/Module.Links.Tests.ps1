#TODO: Convert to PoshSpec

$Links = @()
$MarkdownLinks = Get-ChildItem $PSScriptRoot\..\* -Include '*.md' -Recurse | Select-String '^.*\[.*\]\((http.*)\).*$' -AllMatches
foreach ($Match in $MarkdownLinks)
{
    $Links += @{$Match.Matches.Groups.value[1] = $Match.Path}
}


$Files = $Links.Values | Sort-Object -Unique
    
    
Describe "Testing Resources" {
    
    foreach ($File in $Files)
    {
        Context "Testing Links: [$($File)]" {
            $FileLinks = $Links | Where-Object { $_.Values -eq $File}

            foreach ($Link in $FileLinks)
            {
                $Link = ($Link.Keys | Out-String).Trim()
                
                It "[$($Link)] should have 200 Status Code" {
                
                    $Results = Invoke-WebRequest -Uri $Link -UseBasicParsing
                    $Results.StatusCode | Should Be '200'
                }
            }
        }
    }
}