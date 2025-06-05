<#
.SYNOPSIS
    This script is prepared to quickly create/enable firewall rules on local Windows Server.

.NOTES
    Author: Gyan Mainali
#>

#Enable Rules
Get-NetFirewallRule -DisplayName "File and Printer Sharing (SMB-In)" | Enable-NetFirewallRule
Get-NetFirewallRule -DisplayName "File and Printer Sharing (Echo Request - ICMPv4-In)" | Enable-NetFirewallRule
Get-NetFirewallRule -DisplayName "File and Printer Sharing (SMB-Out)" | Enable-NetFirewallRule
Get-NetFirewallRule -DisplayName "File and Printer Sharing (Echo Request - ICMPv4-Out)" | Enable-NetFirewallRule
Get-NetFirewallRule -DisplayName "COM+ Network Access (DCOM-In)"  | Enable-NetFirewallRule
Get-NetFirewallRule -DisplayName "COM+ Remote Administration (DCOM-In)" | Enable-NetFirewallRule
Get-NetFirewallRule -DisplayName "Distributed Transaction Coordinator (RPC)" | Enable-NetFirewallRule
Get-NetFirewallRule -DisplayName "Distributed Transaction Coordinator (RPC-EPMAP)" | Enable-NetFirewallRule
Get-NetFirewallRule -DisplayName "Distributed Transaction Coordinator (TCP-In)" | Enable-NetFirewallRule
Get-NetFirewallRule -DisplayName "Distributed Transaction Coordinator (TCP-Out)" | Enable-NetFirewallRule

#Inbound
New-NetFirewallRule -DisplayName "IN" -Direction Inbound -Profile Any -Action Allow -Protocol TCP -LocalPort 21,25,80,135,443,445,49152-65535

#Outbound
New-NetFirewallRule -DisplayName "OUT" -Direction Outbound -Profile Any -Action Allow -Protocol TCP -LocalPort 21,25,80,135,443,445,49152-65535

#Inbound App Specific
New-NetFirewallRule -DisplayName "App_1433_TCP" -Direction Inbound -Profile Any -Action Allow -Protocol TCP -LocalPort 1433
New-NetFirewallRule -DisplayName "App_1434_UDP" -Direction Inbound -Profile Any -Action Allow -Protocol UDP -LocalPort 1434

#Outbound App Specific
New-NetFirewallRule -DisplayName "App_1433_TCP" -Direction Outbound -Profile Any -Action Allow -Protocol TCP -LocalPort 1433
New-NetFirewallRule -DisplayName "App_1434_UDP" -Direction Outbound -Profile Any -Action Allow -Protocol UDP -LocalPort 1434

cls;
#Verify Platform Rules
$hostname = hostname
Write-Host "Platform Firewall Rules Status for hostname:" $hostname -ForegroundColor Cyan
Write-Host "========================================================================"
Get-NetFirewallRule -DisplayName "File and Printer Sharing (SMB-In)" | Select DisplayName, Profile, Direction, Enabled
Get-NetFirewallRule -DisplayName "File and Printer Sharing (Echo Request - ICMPv4-In)" | Select DisplayName, Profile, Direction, Enabled
Get-NetFirewallRule -DisplayName "File and Printer Sharing (SMB-Out)" | Select DisplayName, Profile, Direction, Enabled
Get-NetFirewallRule -DisplayName "File and Printer Sharing (Echo Request - ICMPv4-Out)" | Select DisplayName, Profile, Direction, Enabled
Write-Host "========================================================================"

#Verify Application Rules
Write-Host "Application Firewall Rules Status for hostname:" $hostname  -ForegroundColor Cyan
Get-NetFirewallRule -DisplayName "COM+ Network Access (DCOM-In)" | Select DisplayName, Profile, Direction, Enabled
Get-NetFirewallRule -DisplayName "COM+ Remote Administration (DCOM-In)" | Select DisplayName, Profile, Direction,  Enabled
Get-NetFirewallRule -DisplayName "Distributed Transaction Coordinator (RPC)" | Select DisplayName, Profile, Direction, Enabled
Get-NetFirewallRule -DisplayName "Distributed Transaction Coordinator (RPC-EPMAP)" | Select DisplayName, Profile, Direction, Enabled
Get-NetFirewallRule -DisplayName "Distributed Transaction Coordinator (TCP-In)" | Select DisplayName, Profile, Direction, Enabled
Get-NetFirewallRule -DisplayName "Distributed Transaction Coordinator (TCP-Out)" | Select DisplayName, Profile, Direction, Enabled
Get-NetFirewallRule -DisplayName "IN" | Select DisplayName, Profile, Direction, Enabled
Get-NetFirewallRule -DisplayName "OUT" | Select DisplayName, Profile, Direction, Enabled
Write-Host "========================================================================"


# Enable/Disable Firewall
Command: netsh advfirewall set allprofiles state off
or
PowerShell: Set-NetFirewallProfile -All -Enabled True
PowerShell: Set-NetFirewallProfile -All -Enabled False

# Enable/Disable Firewall Remotely
Invoke-Command -ComputerName Server01 -ScriptBlock {netsh advfirewall show allprofiles}
Invoke-Command -ComputerName Server01 -ScriptBlock {netsh advfirewall set allprofiles state off}
Invoke-Command -ComputerName Server01 -ScriptBlock {netsh advfirewall set allprofiles state on}

# Check Remote Desktop firewall rule is enabled
Get-NetFirewallRule -DisplayName "Remote Desktop*" | Select DisplayName, Enabled


