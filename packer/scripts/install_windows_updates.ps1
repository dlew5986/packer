#Requires -RunAsAdministrator

$patches = Start-WuScan | Where-Object {$_.Title -notlike "*Silverlight*"}

if ($patches)
{
    Install-WUUpdates -Updates $patches
}
