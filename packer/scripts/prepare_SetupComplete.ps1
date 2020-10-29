#Requires -RunAsAdministrator

# create folder if it does not already exist
if ( -not (Test-Path -Path 'C:\Windows\Setup\Scripts') )
{
    New-Item -Path 'C:\Windows\Setup' -Name 'Scripts' -ItemType Directory -Force -Confirm:$false
}

# copy SetupComplete.cmd to local
Copy-Item -Path 'A:\SetupComplete.cmd' -Destination 'C:\Windows\Setup\Scripts\SetupComplete.cmd' -Force -Confirm:$false

# copy SetupComplete.ps1 to local
Copy-Item -Path 'A:\SetupComplete.ps1' -Destination 'C:\Windows\Setup\Scripts\SetupComplete.ps1' -Force -Confirm:$false
