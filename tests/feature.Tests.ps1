Describe "Feature Validation"{

    Context "Windows Features"{

        It "should not have Web-Server Role installed" {
            (Get-WindowsFeature -Name "Web-Server").Installed | should be $false
        }

        It "should not have Web-Mgmt-Service Role installed" {
            (Get-WindowsFeature -Name "Web-Mgmt-Service").Installed | should be $false
        }

        It "should not have Web-Asp-Net45 Role installed" {
            (Get-WindowsFeature -Name "Web-Asp-Net45").Installed | should be $false
        }

    }
}