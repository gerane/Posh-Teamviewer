# Grab nuget bits, install modules, set build variables, start build.
#$Null = Get-PackageProvider -Name NuGet -ForceBootstrap

#Install-Module Psake, PSDeploy, Pester, BuildHelpers, PSScriptAnalyzer -force
Import-Module Psake, BuildHelpers

Set-BuildEnvironment

Invoke-psake .\Build.PSake.ps1