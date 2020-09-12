
# verify SetupComplete.ps1 is working
New-Item -Path 'C:\Temp' -ItemType Directory -Confirm:$false
Get-ChildItem Env: | Out-File -FilePath 'C:\Temp\env.txt'
(Get-Date).ToString() | Out-File -FilePath 'C:\Temp\date.txt'
