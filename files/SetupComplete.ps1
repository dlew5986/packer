
# verify SetupComplete.ps1 is working
(Get-Date).ToString() | Out-File -FilePath 'C:\Windows\Temp\SetupCompleted.date.txt'
