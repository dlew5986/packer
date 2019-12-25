<powershell>

# disable the default firewall rules for WinRM
Get-NetFirewallRule -DisplayGroup "Windows Remote Management" | Set-NetFirewallRule -Enabled "False" -Confirm:$false

# new firewall rule to allow WinRM 5985/tcp inbound
#New-NetFirewallRule -DisplayName "allow WinRm inbound (5985/tcp)" -Direction Inbound -Protocol tcp -LocalPort 5985 -RemoteAddress Any -Action Allow
$WinRmParams = @{
    DisplayName = "allow WinRm inbound (5985/tcp)"
    Direction = "Inbound"
    Protocol = "tcp"
    LocalPort = 5985
    RemoteAddress = "Any"
    Action = "Allow"
}
New-NetFirewallRule @WinRmParams

# config winrm for packer to use (must reduce to unencrypted and basic auth)
winrm set winrm/config/service/auth '@{Basic="true"}'
winrm set winrm/config/service '@{AllowUnencrypted="true"}'

</powershell>
