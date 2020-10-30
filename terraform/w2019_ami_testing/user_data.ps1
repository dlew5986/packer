<powershell>
#Requires -RunAsAdministrator

# disable default firewall rules for Remote Desktop
# new, non-system-defined firewall rules were added to the source packer ami
# ...so these system-defined firewall rules are unnecessary (and potentially troublesome)
# ...they're better off disabled (especially because aws keeps re-enabling RDP shadow)
Disable-NetFirewallRule -DisplayGroup "Remote Desktop" -Confirm:$false

</powershell>
