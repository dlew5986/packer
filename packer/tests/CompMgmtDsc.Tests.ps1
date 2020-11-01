Describe "ComputerManagementDsc Validation" {

    Context "IE Enhanced Security Configuration" {

        It "should be disabled for Administrators" {
            $registryKey = 'HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}'
            (Get-ItemProperty -Path $registryKey).IsInstalled | should be 0
        }

    }

    Context "Remote Desktop Settings" {

        It "remote desktop should be present" {
            $registryKey = 'HKLM:\System\CurrentControlSet\Control\Terminal Server'
            (Get-ItemProperty -Path $registryKey).fDenyTSConnections | should be 0
        }

        It "user authentication should be 'secure' (aka Network Level Authentication)" {
            $registryKey = 'HKLM:\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp'
            (Get-ItemProperty -Path $registryKey).UserAuthentication | should be 1
        }

    }

}