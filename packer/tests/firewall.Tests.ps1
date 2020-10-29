Describe "Firewall" {

    $displayGroupsThatShouldBeEnabled = @(
        'Core Networking'
        'Custom'
    )

    Context "Inbound rules that should be enabled" {

        $rules = Get-NetFirewallRule -DisplayGroup $displayGroupsThatShouldBeEnabled -Direction Inbound | Sort-Object -Property DisplayGroup,Profile,DisplayName

        foreach ($rule in $rules)
        {
            It "[$($rule.DisplayGroup)][$($rule.Profile)] $($rule.DisplayName) should be enabled" {
                $rule.Enabled | ForEach-Object { $_.ToString() } | ForEach-Object { [System.Convert]::ToBoolean($_) } | should be $true
            }
        }

    }

    Context "All other inbound rules should be disabled" {

        $rules = Get-NetFirewallRule -Direction Inbound | Where-Object { $displayGroupsThatShouldBeEnabled -notcontains $_.DisplayGroup } | Sort-Object -Property DisplayGroup,Profile,DisplayName

        foreach ($rule in $rules)
        {
            It "[$($rule.DisplayGroup)][$($rule.Profile)] $($rule.DisplayName) should be disabled" {
                $rule.Enabled | ForEach-Object { $_.ToString() } | ForEach-Object { [System.Convert]::ToBoolean($_) } | should be $false
            }
        }

    }

}