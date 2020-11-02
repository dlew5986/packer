Describe "Gui Settings Validation" {

    Context "disable network discovery" {
        $registryKey = 'HKLM:\System\CurrentControlSet\Control\Network\NewNetworkWindowOff'
        It "the registry key should exist" {
            (Test-Path -Path $registryKey) | should be $true
        }
    }

    Context "show hidden files" {
        $registryKey = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced'
        It "the registry key should exist" {            
            (Test-Path -Path $registryKey) | should be $true
        }
        It "the registry property name should exist" {
            ((Get-ItemProperty -Path $registryKey).PSObject.Properties.Name -contains 'Hidden') | should be $true
        }
        It "the registry property value should be 1" {
            (Get-ItemProperty -Path $registryKey).Hidden | should be 1
        }
    }

    Context "show file extensions" {
        $registryKey = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced'
        It "the registry key should exist" {            
            (Test-Path -Path $registryKey) | should be $true
        }
        It "the registry property name should exist" {
            ((Get-ItemProperty -Path $registryKey).PSObject.Properties.Name -contains 'HideFileExt') | should be $true
        }
        It "the registry property value should be 0" {
            (Get-ItemProperty -Path $registryKey).HideFileExt | should be 0
        }
    }

    Context "use small taskbar icons" {
        $registryKey = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced'
        It "the registry key should exist" {            
            (Test-Path -Path $registryKey) | should be $true
        }
        It "the registry property name should exist" {
            ((Get-ItemProperty -Path $registryKey).PSObject.Properties.Name -contains 'TaskbarSmallIcons') | should be $true
        }
        It "the registry property value should be 1" {
            (Get-ItemProperty -Path $registryKey).TaskbarSmallIcons | should be 1
        }
    }

    Context "never combine taskbar buttons" {
        $registryKey = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced'
        It "the registry key should exist" {            
            (Test-Path -Path $registryKey) | should be $true
        }
        It "the registry property name should exist" {
            ((Get-ItemProperty -Path $registryKey).PSObject.Properties.Name -contains 'TaskbarGlomLevel') | should be $true
        }
        It "the registry property value should be 2" {
            (Get-ItemProperty -Path $registryKey).TaskbarGlomLevel | should be 2
        }
    }

    Context "always show all icons in the notification area" {
        $registryKey = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer'
        It "the registry key should exist" {
            (Test-Path -Path $registryKey) | should be $true
        }
        It "the registry property name should exist" {
            ((Get-ItemProperty -Path $registryKey).PSObject.Properties.Name -contains 'EnableAutoTray') | should be $true
        }
        It "the registry property value should be 0" {
            (Get-ItemProperty -Path $registryKey).EnableAutoTray | should be 0
        }
    }

}
