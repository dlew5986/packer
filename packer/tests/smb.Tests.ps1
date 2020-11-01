Describe "SmbServer Validation" {

    Context "SmbServer Configuration" {

        $smbServer = Get-SmbServerConfiguration
        
        It "Smb v1 should be disabled" {
            $smbServer.EnableSMB1Protocol | should be $false
        }
        It "Smb v1 access auditing should be disabled" {
            $smbServer.AuditSmb1Access | should be $false
        }

    }

}
