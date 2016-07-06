Deploy Posh-Teamviewer {
    
    By PlatyPS {
        FromSource "$BHProjectPath\docs\Commands"
        To "$BHProjectPath\Posh-Teamviewer\en-US"
        Tagged Help
        WithOptions @{
            Force = $true
        }
    }

    By FileSystem {
        FromSource $ENV:BHProjectName
        To "$home\Documents\WindowsPowerShell\Modules\Posh-Teamviewer"
        Tagged Prod, Module, Local
        WithOptions @{
            Mirror = $true
        }
        WithPostScript {
            Import-Module -Name Posh-Teamviewer -Force
        }
    }

    By PSGalleryModule {
        FromSource $ENV:BHProjectName
        To PSGallery
        Tagged PSGallery
        WithOptions @{
            ApiKey = $ENV:NugetApiKey
        }
    }
}