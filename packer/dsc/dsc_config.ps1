#Requires -RunAsAdministrator
#Requires -module NetworkingDsc
#Requires -module ComputerManagementDsc

Configuration DscConfig
{
    param (
        [string[]]$NodeName = 'localhost'
    )

    Import-DscResource -ModuleName PSDesiredStateConfiguration
    Import-DscResource -ModuleName NetworkingDsc
    Import-DscResource -ModuleName ComputerManagementDsc

    Node $NodeName
    {
        Service PrintSpooler
        {
            Name        = 'Spooler'
            StartupType = 'Manual'
            State       = 'Stopped'
        }

        TimeZone SetTimeZone
        {
            IsSingleInstance = 'Yes'
            TimeZone         = 'Eastern Standard Time'
        }

        SmbServerConfiguration DisableSmb1
        {
            IsSingleInstance   = 'Yes'
            AuditSmb1Access    = $false
            EnableSMB1Protocol = $false
        }

        IEEnhancedSecurityConfiguration DisableForAdministrators
        {
            Role            = 'Administrators'
            Enabled         = $false
            SuppressRestart = $true
        }

        RemoteDesktopAdmin RemoteDesktopSettings
        {
            IsSingleInstance   = 'yes'
            Ensure             = 'Present'
            UserAuthentication = 'Secure'
        }

        NetBios DisableNetBios
        {
            InterfaceAlias = '*'
            Setting        = 'Disable'
        }

        WinsSetting ConfigureWinsSettings
        {
            IsSingleInstance = 'Yes'
            EnableLMHOSTS    = $false
            EnableDNS        = $false
        }

        FirewallProfile ConfigureDomainFirewallProfile
        {
            Name                  = 'Domain'
            Enabled               = 'True'
            DefaultInboundAction  = 'Block'
            DefaultOutboundAction = 'Allow'
        }

        FirewallProfile ConfigurePublicFirewallProfile
        {
            Name                  = 'Public'
            Enabled               = 'True'
            DefaultInboundAction  = 'Block'
            DefaultOutboundAction = 'Allow'
        }

        FirewallProfile ConfigurePrivateFirewallProfile
        {
            Name                  = 'Private'
            Enabled               = 'True'
            DefaultInboundAction  = 'Block'
            DefaultOutboundAction = 'Allow'
        }

        Firewall AllowICMPv4EchoInbound
        {
            Name          = 'AllowICMPv4EchoInbound'
            Ensure        = 'Present'
            Enabled       = 'True'
            DisplayName   = 'allow ICMPv4 echo inbound'
            Group         = 'Custom'
            Direction     = 'Inbound'
            Protocol      = 'ICMPv4'
            IcmpType      = '8'
            RemoteAddress = 'Any'
            Action        = 'Allow'
        }

        Firewall AllowRdpInboundOnTcp3389
        {
            Name          = 'AllowRdpInboundOnTcp3389'
            Ensure        = 'Present'
            Enabled       = 'True'
            DisplayName   = 'allow RDP inbound on 3389/tcp'
            Group         = 'Custom'
            Direction     = 'Inbound'
            Protocol      = 'tcp'
            LocalPort     = '3389'
            RemoteAddress = 'Any'
            Action        = 'Allow'
        }

        Firewall AllowRdpInboundOnUdp3389
        {
            Name          = 'AllowRdpInboundOnUdp3389'
            Ensure        = 'Present'
            Enabled       = 'True'
            DisplayName   = 'allow RDP inbound on 3389/udp'
            Group         = 'Custom'
            Direction     = 'Inbound'
            Protocol      = 'udp'
            LocalPort     = '3389'
            RemoteAddress = 'Any'
            Action        = 'Allow'
        }

        Firewall AllowWinRmInboundOnTcp5986
        {
            Name          = 'AllowWinRmInboundOnTcp5986'
            Ensure        = 'Present'
            Enabled       = 'True'
            DisplayName   = 'allow WinRM inbound on 5986/tcp'
            Group         = 'Custom'
            Direction     = 'Inbound'
            Protocol      = 'tcp'
            LocalPort     = '5986'
            RemoteAddress = 'Any'
            Action        = 'Allow'
        }

        $displayGroupsThatShouldBeEnabled = @(
            'Core Networking'
            'Custom'
        )

        # firewall rules that should be disabled
        $rules = Get-NetFirewallRule  -Direction Inbound -Enabled True | Where-Object { $displayGroupsThatShouldBeEnabled -notcontains $_.DisplayGroup }

        foreach ($rule in $rules)
        {
            Firewall $rule.Name
            {
                Name    = $rule.Name
                Ensure  = 'Present'
                Enabled = 'False'
            }
        }
        
    }
}

# create the mof file
$dscConfigParams = @{
    NodeName   = 'localhost'
    OutputPath = 'C:\dsc'
}
DscConfig @dscConfigParams

# create a cim session to be fed into Start-DscConfiguration
# by default Start-DscConfiguration establishes an http-based WinRM session
# the http WinRM listener doesn't exist (it was deleted in user_data_aws.ps1)
# this is an ugly workaround; it should be corrected at some point
$session = New-CimSession

# invoke the lcm to process the mof file
$startParams = @{
    CimSession   = $session
    Path         = 'C:\dsc'
    Force        = $true
    Verbose      = $true
    Wait         = $true
}
Start-DscConfiguration @startParams
