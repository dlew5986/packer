Describe "Firewall Validation" {

    $displayGroupsThatShouldBeEnabled = @(
        'Core Networking'
        'Custom'
    )

    Context "Firewall profiles" {

        $firewallProfiles = Get-NetFirewallProfile

        foreach ($firewallProfile in $firewallProfiles)
        {
            It "[$($firewallProfile.Name) profile] should be enabled" {
                $firewallProfile.Enabled | should be $true
            }
            It "[$($firewallProfile.Name) profile] default inbound action should be 'block'" {
                $firewallProfile.DefaultInboundAction | should be 'block'
            }
            It "[$($firewallProfile.Name) profile] default outbound action should be 'allow'" {
                $firewallProfile.DefaultOutboundAction | should be 'allow'
            }
        }

    }

    Context "Inbound rules that should be enabled" {

        $rules = Get-NetFirewallRule -DisplayGroup $displayGroupsThatShouldBeEnabled -Direction Inbound | Sort-Object -Property DisplayGroup,Profile,DisplayName

        foreach ($rule in $rules)
        {
            It "[$($rule.DisplayGroup)][$($rule.Profile)] $($rule.DisplayName) should be enabled" {
                $rule.Enabled | ForEach-Object { $_.ToString() } | ForEach-Object { [System.Convert]::ToBoolean($_) } | should be $true
            }
        }

    }

    Context "Inbound rules that should be disabled" {

        $rules = Get-NetFirewallRule -Direction Inbound | Where-Object { $displayGroupsThatShouldBeEnabled -notcontains $_.DisplayGroup } | Sort-Object -Property DisplayGroup,Profile,DisplayName

        foreach ($rule in $rules)
        {
            It "[$($rule.DisplayGroup)][$($rule.Profile)] $($rule.DisplayName) should be disabled" {
                $rule.Enabled | ForEach-Object { $_.ToString() } | ForEach-Object { [System.Convert]::ToBoolean($_) } | should be $false
            }
        }

    }

}