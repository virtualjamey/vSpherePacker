# Turn the firewall back on!!!
Write-Host "Enable Windows Firewall"
netsh Advfirewall set allprofiles state on

#Enable RDP
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -name "fDenyTSConnections" -value 0
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"