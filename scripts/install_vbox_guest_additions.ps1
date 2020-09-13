
#Requires -RunAsAdministrator

if (Test-Path 'D:/VBoxWindowsAdditions.exe')
{
    Get-ChildItem D:\cert\ -Filter vbox*.cer | ForEach-Object { D:\cert\VBoxCertUtil.exe add-trusted-publisher $_.FullName --root $_.FullName }
    Start-Process -FilePath 'D:/VBoxWindowsAdditions.exe' -ArgumentList '/S' -Wait
}
elseif (Test-Path 'E:/VBoxWindowsAdditions.exe')
{
    Get-ChildItem E:\cert\ -Filter vbox*.cer | ForEach-Object { E:\cert\VBoxCertUtil.exe add-trusted-publisher $_.FullName --root $_.FullName }
    Start-Process -FilePath 'E:/VBoxWindowsAdditions.exe' -ArgumentList '/S' -Wait
}

#########
# future: get the CDROM drive letter rather than testing blindly for it
#########
