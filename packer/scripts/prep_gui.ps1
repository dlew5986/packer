#Requires -RunAsAdministrator

# these settings must be config'ed outside of dsc because they're in HKCU
# the dsc lcm runs under SYSTEM (not Administrator)
# so making changes to HKCU from within the dsc lcm doesn't go anywhere useful

# show hidden files
$newParams = @{
    Path         = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced'
    Name         = 'Hidden'
    PropertyType = 'DWord'
    Value        = '1'
    Force        = $true
}
New-ItemProperty @newParams

# show file extensions
$newParams = @{
    Path         = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced'
    Name         = 'HideFileExt'
    PropertyType = 'DWord'
    Value        = '0'
    Force        = $true
}
New-ItemProperty @newParams

# use small taskbar icons
$newParams = @{
    Path         = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced'
    Name         = 'TaskbarSmallIcons'
    PropertyType = 'DWord'
    Value        = '1'
    Force        = $true
}
New-ItemProperty @newParams

# never combine taskbar buttons
$newParams = @{
    Path         = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced'
    Name         = 'TaskbarGlomLevel'
    PropertyType = 'DWord'
    Value        = '2'
    Force        = $true
}
New-ItemProperty @newParams

# always show all icons in the notification area
$newParams = @{
    Path         = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer'
    Name         = 'EnableAutoTray'
    PropertyType = 'DWord'
    Value        = '0'
    Force        = $true
}
New-ItemProperty @newParams
