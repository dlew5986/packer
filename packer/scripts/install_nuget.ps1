#Requires -RunAsAdministrator

# install the NuGet package provider to enable pulling modules down from PowerShell Gallery
Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force -Confirm:$false
