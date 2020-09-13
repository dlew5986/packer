#Requires -RunAsAdministrator

# Script to force the .NET Framework optimization service to run at maximum speed.
# Downloaded from <link below> on 11/6/2017
#   https://github.com/Microsoft/dotnet/blob/master/tools/DrainNGENQueue/DrainNGenQueue.ps
# Reference...
#   https://blogs.msdn.microsoft.com/dotnet/2013/08/06/got-a-need-for-speed-net-apps-start-faster/
#   https://blogs.msdn.microsoft.com/dotnet/2013/08/06/wondering-why-mscorsvw-exe-has-high-cpu-usage-you-can-speed-it-up/
#
# modified from source by dlew5986 in the following ways:
# 1 - changed Write-Host to Write-Output
# 2 - spacing
# 3 - added start/stop
# 4 - added datetime stamp to outputs
#

# create filter to add a date/time stamp to outputs
filter timestamp {"$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss'): $_"}


Write-Output 'Starting dotnet optimization script...' | timestamp

$isWin8Plus = [Environment]::OSVersion.Version -ge (new-object 'Version' 6,2)
$dotnetDir = [Environment]::GetEnvironmentVariable('windir','Machine') + '\Microsoft.NET\Framework'
$dotnet2 = 'v2.0.50727'
$dotnet4 = 'v4.0.30319'

$dotnetVersion = if (Test-Path ($dotnetDir + '\' + $dotnet4 + '\ngen.exe')) {$dotnet4} else {$dotnet2}

$ngen32 = $dotnetDir + '\' + $dotnetVersion +'\ngen.exe'
$ngen64 = $dotnetDir + '64\' + $dotnetVersion +'\ngen.exe'
$ngenArgs = ' executeQueuedItems'
$is64Bit = Test-Path $ngen64


#32-bit NGEN -- appropriate for 32-bit and 64-bit machines
Write-Output 'Requesting 32-bit NGEN' | timestamp
Start-Process -wait $ngen32 -ArgumentList $ngenArgs

#64-bit NGEN -- appropriate for 64-bit machines
if ($is64Bit) {
    Write-Output 'Requesting 64-bit NGEN' | timestamp
    Start-Process -wait $ngen64 -ArgumentList $ngenArgs
}

#AutoNGEN for Windows 8+ machines
if ($isWin8Plus) {
    Write-Output 'Requesting 32-bit AutoNGEN -- Windows 8+' | timestamp
    schTasks /run /Tn '\Microsoft\Windows\.NET Framework\.NET Framework NGEN v4.0.30319'
}

#64-bit AutoNGEN for Windows 8+ machines
if ($isWin8Plus -and $is64Bit) {
    Write-Output 'Requesting 64-bit AutoNGEN -- Windows 8+' | timestamp
    schTasks /run /Tn '\Microsoft\Windows\.NET Framework\.NET Framework NGEN v4.0.30319 64'
}

Write-Output 'Ending dotnet optimization script...' | timestamp
