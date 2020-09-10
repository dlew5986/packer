<powershell>

# disable the default firewall rules for WinRM
Disable-NetFirewallRule -DisplayGroup 'Windows Remote Management' -Confirm:$false

# new firewall rule to allow WinRM 5986/tcp inbound
$WinRmHttpsParams = @{
    DisplayName   = "allow WinRM inbound on 5986/tcp"
    Direction     = "Inbound"
    Protocol      = "tcp"
    LocalPort     = 5986
    RemoteAddress = "Any"
    Action        = "Allow"
}
New-NetFirewallRule @WinRmHttpsParams | Out-Null

# remove winrm http listener
$removeWinRmListenerParams = @{
    ResourceURI = "winrm/config/listener"
    SelectorSet = @{
        Address   = "*"
        Transport = "http"
    }
}
Remove-WSManInstance @removeWinRmListenerParams

# create self-signed cert
$selfSignedCertParams = @{
    CertStoreLocation = "Cert:\LocalMachine\My"
    DnsName           = "packer-ami"
}
$selfSignedCert = New-SelfSignedCertificate @selfSignedCertParams

# create winrm https listener
$newWinRmListenerParams = @{
    ResourceURI = "winrm/config/listener"
    SelectorSet = @{
        Address   = "*"
        Transport = "https"
    }
    ValueSet = @{
        CertificateThumbprint = $selfSignedCert.Thumbprint
    }
}
New-WSManInstance @newWinRmListenerParams

</powershell>
