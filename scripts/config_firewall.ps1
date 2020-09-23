#Requires -RunAsAdministrator

# new firewall rule to allow ICMPv4 echo inbound
$IcmpEchoParams = @{
    DisplayName   = 'allow ICMPv4 echo inbound'
    Group         = 'Custom'
    Direction     = 'Inbound'
    Protocol      = 'ICMPv4'
    IcmpType      = 8
    RemoteAddress = 'Any'
    Action        = 'Allow'
}
New-NetFirewallRule @IcmpEchoParams | Out-Null

# new firewall rule to allow RDP 3389/tcp inbound
$RdpTcpParams = @{
    DisplayName   = 'allow RDP inbound on 3389/tcp'
    Group         = 'Custom'
    Direction     = 'Inbound'
    Protocol      = 'tcp'
    LocalPort     = 3389
    RemoteAddress = 'Any'
    Action        = 'Allow'
}
New-NetFirewallRule @RdpTcpParams | Out-Null

# new firewall rule to allow RDP 3389/udp inbound
$RdpUdpParams = @{
    DisplayName   = 'allow RDP inbound on 3389/udp'
    Group         = 'Custom'
    Direction     = 'Inbound'
    Protocol      = 'udp'
    LocalPort     = 3389
    RemoteAddress = 'Any'
    Action        = 'Allow'
}
New-NetFirewallRule @RdpUdpParams | Out-Null

# disable all the other inbound firewall rules except that which should be enabled
$displayGroupsThatShouldBeEnabled = @(
    'Core Networking'
    'Custom'
)
$rules = Get-NetFirewallRule -Direction Inbound | Where-Object { $displayGroupsThatShouldBeEnabled -notcontains $_.DisplayGroup }

foreach ($rule in $rules)
{
    Disable-NetFirewallrule -DisplayGroup $rule.DisplayGroup -Confirm:$false
}
