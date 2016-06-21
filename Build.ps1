# Grab nuget bits, install modules, set build variables, start build.
$Null = Get-PackageProvider -Name NuGet -ForceBootstrap

Install-Module PlatyPS -RequiredVersion 0.4.0 -Force
Install-Module Psake, PSDeploy, Pester, BuildHelpers, PSScriptAnalyzer -force
Import-Module Psake, BuildHelpers, PlatyPS, PSDeploy, Pester

Set-BuildEnvironment

Invoke-psake .\Build.Psake.ps1
exit ( [int]( -not $psake.build_success ) )