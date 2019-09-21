
REM reference:
REM https://blogs.msdn.microsoft.com/sergey_babkins_blog/2017/01/05/how-to-run-powershell-from-setupcomplete-cmd/

REM reference:
REM http://blogs.inframon.com/2016/09/deployment-custom-os-image-add-a-custom-powershell-script-to-windows-setup/

REM reference:
REM http://techthoughts.info/custom-nano-deployment-setupcomplete/

C:\Windows\System32\WindowsPowerShell\v1.0\Powershell.exe -NonInteractive -NoProfile -ExecutionPolicy Unrestricted -File C:\Windows\Setup\Scripts\SetupComplete.ps1

