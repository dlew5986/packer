Describe "ComputerManagementDsc Validation" {

    Context "IE Enhanced Security Configuration" {

        It "should be disabled for Administrators" {
            $registryKey = 'HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}'
            (Get-ItemProperty -Path $registryKey).IsInstalled | should be 0
        }

    }

}