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

# modules to install
$modulesToInstall = @(
    'PSDscResources'
    'NetworkingDsc'
    'ComputerManagementDsc'
)

# install modules from the PowerShell Gallery
$modulesParams = @{
    Name    = $modulesToInstall
    Scope   = 'AllUsers'
    Force   = $true
}
Install-Module @modulesParams
