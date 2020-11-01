Describe "Service Validation" {

    Context "Print Spooler" {

        $svc = Get-Service -Name 'spooler'

        It "should be stopped" {
            $svc.Status | should be 'stopped'
        }
        It "startup type should be 'automatic'" {
            $svc.StartType | should be 'manual'
        }

    }

}