
# an attempt to turn off the prompt to do dumb stuff
# if this works it should probably be moved to its own script
#reg add HKLM\System\CurrentControlSet\Control\Network\NewNetworkWindowOff /f
# pretty sure this^ does not work

# config winrm for packer to use (must reduce to unencrypted and basic auth)
winrm set winrm/config/service/auth '@{Basic="true"}'
winrm set winrm/config/service '@{AllowUnencrypted="true"}'


#####################
# future: change this to pure powershell
#####################
