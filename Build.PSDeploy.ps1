Deploy Posh-Teamviewer {
    By FileSystem Modules {
        FromSource $ENV:BHProjectName
        To "$home\Documents\WindowsPowerShell\Modules\Posh-Teamviewer"
        Tagged Prod, Module, Local
        WithOptions @{
            Mirror = $true
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