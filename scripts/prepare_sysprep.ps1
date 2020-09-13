#Requires -RunAsAdministrator

# create Unattend folder if it does not already exist
if ( -not (Test-Path -Path 'C:\Windows\Panther\Unattend') )
{
    New-Item -Path 'C:\Windows\Panther' -Name 'Unattend' -ItemType Directory -Force -Confirm:$false
}

# copy Unattend.xml from to local
Copy-Item -Path 'A:\sysprep_unattend.xml' -Destination 'C:/Windows/Panther/Unattend/Unattend.xml' -Force -Confirm:$false

# copy sysprep_shutdown.cmd to local
Copy-Item -Path 'A:\sysprep_shutdown.cmd' -Destination 'C:/Windows/Panther/Unattend/sysprep_shutdown.cmd' -Force -Confirm:$false
