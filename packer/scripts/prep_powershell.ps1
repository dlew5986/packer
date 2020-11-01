#Requires -RunAsAdministrator

# update the help files because reasons
Update-Help -Force -ErrorAction SilentlyContinue

# install the NuGet package provider to enable pulling modules down from the PowerShell Gallery
$nugetParams = @{
    Name    = 'NuGet'
    Scope   = 'AllUsers'
    Force   = $true
}
Install-PackageProvider @nugetParams

# install various modules from the PowerShell Gallery
$modulesParams = @{
    Name    = 'PSDscResources','NetworkingDsc'
    Scope   = 'AllUsers'
    Force   = $true
}
Install-Module @modulesParams
