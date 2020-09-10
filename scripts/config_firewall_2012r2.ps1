
# new firewall rule to allow ICMPv4 echo inbound
$IcmpEchoParams = @{
    DisplayName   = "allow ICMPv4 echo inbound"
    Direction     = "Inbound"
    Protocol      = "ICMPv4"
    IcmpType      = 8
    RemoteAddress = "Any"
    Action        = "Allow"
}
New-NetFirewallRule @IcmpEchoParams | Out-Null

# new firewall rule to allow RDP 3389/tcp inbound
$RdpTcpParams = @{
    DisplayName   = "allow RDP inbound on 3389/tcp"
    Direction     = "Inbound"
    Protocol      = "tcp"
    LocalPort     = 3389
    RemoteAddress = "Any"
    Action        = "Allow"
}
New-NetFirewallRule @RdpTcpParams | Out-Null

# new firewall rule to allow RDP 3389/udp inbound
$RdpUdpParams = @{
    DisplayName   = "allow RDP inbound on 3389/udp"
    Direction     = "Inbound"
    Protocol      = "udp"
    LocalPort     = 3389
    RemoteAddress = "Any"
    Action        = "Allow"
}
New-NetFirewallRule @RdpUdpParams | Out-Null

<#
# disable listed firewall groups
$displayGroupsToDisable = @(
    "AllJoyn Router"
    "Cast to Device functionality"
    "Delivery Optimization"
    "DIAL protocol server"
    "mDNS"
    "Remote Desktop"
    "Windows Remote Management"
)
Disable-NetFirewallrule -DisplayGroup $displayGroupsToDisable -Confirm:$false
#>
