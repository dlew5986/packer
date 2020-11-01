Describe "Network Validation" {

    $netAdapters = Get-CimInstance -ClassName Win32_NetWorkAdapterConfiguration | Where-Object {$_.IPEnabled -eq $true} 

    Context "NetBIOS" {

        foreach ($netAdapter in $netAdapters)
        {
            It "[$($netAdapter.Description)] NetBIOS over TCPIP should be disabled" {
                $netAdapter.TcpipNetbiosOptions | should be 2
            }
        }

    }

    Context "WINS Settings" {

        foreach ($netAdapter in $netAdapters)
        {
            It "[$($netAdapter.Description)] WINS lookups to LMHosts should be disabled" {
                $netAdapter.WINSEnableLMHostsLookup | should be $false
            }

            It "[$($netAdapter.Description)] WINS lookups to DNS should be disabled" {
                $netAdapter.DNSEnabledForWINSResolution | should be $false
            }
        }

    }

}
