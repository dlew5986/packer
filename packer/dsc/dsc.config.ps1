#Requires -RunAsAdministrator

Configuration PackerConfig
{
    param (
        [string[]]$NodeName = 'localhost'
    )

    Import-DscResource -ModuleName PSDesiredStateConfiguration
    Import-DscResource -ModuleName NetworkingDsc

    Node $NodeName
    {
        WindowsFeature RSAT
        {
            Name   = 'RSAT'
            Ensure = 'Absent'
        }

        Service PrintSpooler
        {
            Name        = 'Spooler'
            StartupType = 'Manual'
            State       = 'Stopped'
        }

    }
}

# create the mof file
$packerConfigParams = @{
    NodeName   = 'localhost'
    OutputPath = 'C:\Configs'
}
PackerConfig @packerConfigParams

# create a cim session to be fed into Start-DscConfiguration
# by default Start-DscConfiguration establishes an http-based WinRM session
# the http WinRM listener doesn't exist (it was deleted in user_data_aws.ps1)
# this is an ugly workaround
# it should be corrected at some point
$session = New-CimSession

# invoke the lcm to process the mof file
$startParams = @{
    CimSession   = $session
    Path         = 'C:\Configs'    
    Verbose      = $true
    Wait         = $true
}
Start-DscConfiguration @startParams
