
<#
.SYNOPSIS
    This script Harden deprecated SSL and TLS protocols from registry hive.
    Also a reboot is mandatory when Local Machine hive if modified.
	- Alternative to this is IISCrypto Tool
.NOTES
    Author: Gyan Mainali
#>

$SChannelRegPath = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols"


New-ItemProperty -Path $SChannelRegPath"\SSL 2.0\Server" -Name 'Enabled' -Value '1' -PropertyType 'DWord' -Force | Out-Null
New-ItemProperty -Path $SChannelRegPath"\SSL 2.0\Server" -Name 'DisabledByDefault' -Value '0' -PropertyType 'DWord' -Force | Out-Null
Write-Host 'SSL 2.0 Server has been enabled' -ForegroundColor Green

New-ItemProperty -Path $SChannelRegPath"\SSL 2.0\Client" -Name 'Enabled' -Value '1' -PropertyType 'DWord' -Force | Out-Null
New-ItemProperty -Path $SChannelRegPath"\SSL 2.0\Client" -Name 'DisabledByDefault' -Value '0' -PropertyType 'DWord' -Force | Out-Null
Write-Host 'SSL 2.0 Client has been enabled' -ForegroundColor Green

New-ItemProperty -Path $SChannelRegPath"\SSL 3.0\Server" -Name 'Enabled' -Value '1' -PropertyType 'DWord' -Force | Out-Null
New-ItemProperty -Path $SChannelRegPath"\SSL 3.0\Server" -Name 'DisabledByDefault' -Value '0' -PropertyType 'DWord' -Force | Out-Null
Write-Host 'SSL 3.0 Server has been enabled' -ForegroundColor Green

New-ItemProperty -Path $SChannelRegPath"\SSL 3.0\Client" -Name 'Enabled' -Value '1' -PropertyType 'DWord' -Force | Out-Null
New-ItemProperty -Path $SChannelRegPath"\SSL 3.0\Client" -Name 'DisabledByDefault' -Value '0' -PropertyType 'DWord' -Force | Out-Null
Write-Host 'SSL 3.0 Client has been enabled' -ForegroundColor Green

New-ItemProperty -Path $SChannelRegPath"\TLS 1.0\Server" -Name 'Enabled' -Value '0' -PropertyType 'DWord' -Force | Out-Null
New-ItemProperty -Path $SChannelRegPath"\TLS 1.0\Server" -Name 'DisabledByDefault' -Value '1' -PropertyType 'DWord' -Force | Out-Null
Write-Host 'TLS 1.0 Server has been disabled' -ForegroundColor Red

New-ItemProperty -Path $SChannelRegPath"\TLS 1.0\Client" -Name 'Enabled' -Value '0' -PropertyType 'DWord' -Force | Out-Null
New-ItemProperty -Path $SChannelRegPath"\TLS 1.0\Client" -Name 'DisabledByDefault' -Value '1' -PropertyType 'DWord' -Force | Out-Null
Write-Host 'TLS 1.0 Client has been disabled' -ForegroundColor Red

New-ItemProperty -Path $SChannelRegPath"\TLS 1.1\Server" -Name 'Enabled' -Value '0' -PropertyType 'DWord' -Force | Out-Null
New-ItemProperty -Path $SChannelRegPath"\TLS 1.1\Server" -Name 'DisabledByDefault' -Value '1' -PropertyType 'DWord' -Force | Out-Null
Write-Host 'TLS 1.1 Server has been disabled' -ForegroundColor Red

New-ItemProperty -Path $SChannelRegPath"\TLS 1.1\Client" -Name 'Enabled' -Value '0' -PropertyType 'DWord' -Force | Out-Null
New-ItemProperty -Path $SChannelRegPath"\TLS 1.1\Client" -Name 'DisabledByDefault' -Value '1' -PropertyType 'DWord' -Force | Out-Null
Write-Host 'TLS 1.1 Client has been disabled' -ForegroundColor Red

New-ItemProperty -Path $SChannelRegPath"\TLS 1.2\Server" -Name 'Enabled' -Value '1' -PropertyType 'DWord' -Force | Out-Null
New-ItemProperty -Path $SChannelRegPath"\TLS 1.2\Server" -Name 'DisabledByDefault' -Value '0' -PropertyType 'DWord' -Force | Out-Null
Write-Host 'TLS 1.2 Server has been enabled' -ForegroundColor Green

New-ItemProperty -Path $SChannelRegPath"\TLS 1.2\Client" -Name 'Enabled' -Value '1' -PropertyType 'DWord' -Force | Out-Null
New-ItemProperty -Path $SChannelRegPath"\TLS 1.2\Client" -Name 'DisabledByDefault' -Value '0' -PropertyType 'DWord' -Force | Out-Null
Write-Host 'TLS 1.2 Client has been enabled' -ForegroundColor Green

Write-Host 'SSL/TLS changes performed. Please restart the Server for the changes to take affect.' -ForegroundColor Cyan

