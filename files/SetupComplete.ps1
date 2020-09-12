

Import-Module -Name Microsoft.Powershell.Management
New-Item -Path "C:\Temp" -ItemType Directory -Confirm:$false
Get-ChildItem Env: | Out-File -FilePath C:\Temp\env.txt -Confirm:$false



<#
gip | Out-File -FilePath C:\Temp\gip.txt -Force -Confirm:$false
#>

<#
Import-Module Microsoft.Powershell.LocalAccounts
Get-LocalUser -Name "vagrantTest" | Disable-LocalUser -Confirm:$false
#>

<#
[Environment]::SetEnvironmentVariable("TestVariable", "Test value.", "User")
[Environment]::GetEnvironmentVariable("TestVariable","User")
Get-Childitem Env:Computername
#>

#####################
# future: clean this up
#####################
