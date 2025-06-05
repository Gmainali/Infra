<#
.SYNOPSIS
    This script Enables SSL and TLS hive from registry includig .NET hive.
	- .NET side of changes:
		- SystemDefaultTlsVersions (1): Allows .NET applications to use the system's default TLS version.
		- SchUseStrongCrypto (1): Ensures strong cryptographic algorithms and protocols, including TLS 1.2, are used.
    Also a reboot is mandatory when Local Machine hive if modified.
.NOTES
    Author: Gyan Mainali
#>


$SChannelRegPath = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols"

If (-Not (Test-Path 'HKLM:\SOFTWARE\WOW6432Node\Microsoft\.NETFramework\v4.0.30319'))
{
    New-Item 'HKLM:\SOFTWARE\WOW6432Node\Microsoft\.NETFramework\v4.0.30319' -Force | Out-Null
}
New-ItemProperty -Path 'HKLM:\SOFTWARE\WOW6432Node\Microsoft\.NETFramework\v4.0.30319' -Name 'SystemDefaultTlsVersions' -Value '1' -PropertyType 'DWord' -Force | Out-Null
New-ItemProperty -Path 'HKLM:\SOFTWARE\WOW6432Node\Microsoft\.NETFramework\v4.0.30319' -Name 'SchUseStrongCrypto' -Value '1' -PropertyType 'DWord' -Force | Out-Null

If (-Not (Test-Path 'HKLM:\SOFTWARE\Microsoft\.NETFramework\v4.0.30319'))
{
    New-Item 'HKLM:\SOFTWARE\Microsoft\.NETFramework\v4.0.30319' -Force | Out-Null
}
New-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\.NETFramework\v4.0.30319' -Name 'SystemDefaultTlsVersions' -Value '1' -PropertyType 'DWord' -Force | Out-Null
New-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\.NETFramework\v4.0.30319' -Name 'SchUseStrongCrypto' -Value '1' -PropertyType 'DWord' -Force | Out-Null

If (-Not (Test-Path $SChannelRegPath"\SSL 2.0\Server"))
{
    New-Item $SChannelRegPath"\SSL 2.0\Server" -Force | Out-Null
    Write-Host 'SSL 2.0 Server has been disabled.' -ForegroundColor Cyan
}
New-ItemProperty -Path $SChannelRegPath"\SSL 2.0\Server" -Name 'Enabled' -Value '0' -PropertyType 'DWord' -Force | Out-Null
New-ItemProperty -Path $SChannelRegPath"\SSL 2.0\Server" -Name 'DisabledByDefault' -Value '1' -PropertyType 'DWord' -Force | Out-Null

If (-Not (Test-Path $SChannelRegPath"\SSL 2.0\Client"))
{
    New-Item $SChannelRegPath"\SSL 2.0\Client" -Force | Out-Null
    Write-Host 'SSL 2.0 Client has been disabled.' -ForegroundColor Cyan
}
New-ItemProperty -Path $SChannelRegPath"\SSL 2.0\Client" -Name 'Enabled' -Value '0' -PropertyType 'DWord' -Force | Out-Null
New-ItemProperty -Path $SChannelRegPath"\SSL 2.0\Client" -Name 'DisabledByDefault' -Value '1' -PropertyType 'DWord' -Force | Out-Null

If (-Not (Test-Path $SChannelRegPath"\SSL 3.0\Server"))
{
    New-Item $SChannelRegPath"\SSL 3.0\Server" -Force | Out-Null
    Write-Host 'SSL 3.0 Server has been disabled.' -ForegroundColor Cyan
}
New-ItemProperty -Path $SChannelRegPath"\SSL 3.0\Server" -Name 'Enabled' -Value '0' -PropertyType 'DWord' -Force | Out-Null
New-ItemProperty -Path $SChannelRegPath"\SSL 3.0\Server" -Name 'DisabledByDefault' -Value '1' -PropertyType 'DWord' -Force | Out-Null

If (-Not (Test-Path $SChannelRegPath"\SSL 3.0\Client"))
{
    New-Item $SChannelRegPath"\SSL 3.0\Client" -Force | Out-Null
    Write-Host 'SSL 3.0 Client has been disabled.' -ForegroundColor Cyan
}
New-ItemProperty -Path $SChannelRegPath"\SSL 3.0\Client" -Name 'Enabled' -Value '0' -PropertyType 'DWord' -Force | Out-Null
New-ItemProperty -Path $SChannelRegPath"\SSL 3.0\Client" -Name 'DisabledByDefault' -Value '1' -PropertyType 'DWord' -Force | Out-Null


If (-Not (Test-Path $SChannelRegPath"\TLS 1.0\Server"))
{
    New-Item $SChannelRegPath"\TLS 1.0\Server" -Force | Out-Null
    Write-Host 'TLS 1.0 Server has been disabled.' -ForegroundColor Cyan
}
New-ItemProperty -Path $SChannelRegPath"\TLS 1.0\Server" -Name 'Enabled' -Value '0' -PropertyType 'DWord' -Force | Out-Null
New-ItemProperty -Path $SChannelRegPath"\TLS 1.0\Server" -Name 'DisabledByDefault' -Value '1' -PropertyType 'DWord' -Force | Out-Null

If (-Not (Test-Path $SChannelRegPath"\TLS 1.0\Client"))
{
    New-Item $SChannelRegPath"\TLS 1.0\Client" -Force | Out-Null
    Write-Host 'TLS 1.0 Client has been disabled.' -ForegroundColor Cyan
}
New-ItemProperty -Path $SChannelRegPath"\TLS 1.0\Client" -Name 'Enabled' -Value '0' -PropertyType 'DWord' -Force | Out-Null
New-ItemProperty -Path $SChannelRegPath"\TLS 1.0\Client" -Name 'DisabledByDefault' -Value '1' -PropertyType 'DWord' -Force | Out-Null

If (-Not (Test-Path $SChannelRegPath"\TLS 1.1\Server"))
{
    New-Item $SChannelRegPath"\TLS 1.1\Server" -Force | Out-Null
    Write-Host 'TLS 1.1 Server has been disabled.' -ForegroundColor Cyan
}
New-ItemProperty -Path $SChannelRegPath"\TLS 1.1\Server" -Name 'Enabled' -Value '0' -PropertyType 'DWord' -Force | Out-Null
New-ItemProperty -Path $SChannelRegPath"\TLS 1.1\Server" -Name 'DisabledByDefault' -Value '1' -PropertyType 'DWord' -Force | Out-Null

If (-Not (Test-Path $SChannelRegPath"\TLS 1.1\Client"))
{
    New-Item $SChannelRegPath"\TLS 1.1\Client" -Force | Out-Null
    Write-Host 'TLS 1.1 Client has been disabled.' -ForegroundColor Cyan
}
New-ItemProperty -Path $SChannelRegPath"\TLS 1.1\Client" -Name 'Enabled' -Value '0' -PropertyType 'DWord' -Force | Out-Null
New-ItemProperty -Path $SChannelRegPath"\TLS 1.1\Client" -Name 'DisabledByDefault' -Value '1' -PropertyType 'DWord' -Force | Out-Null

If (-Not (Test-Path $SChannelRegPath"\TLS 1.2\Server"))
{
    New-Item $SChannelRegPath"\TLS 1.2\Server" -Force | Out-Null
}
New-ItemProperty -Path $SChannelRegPath"\TLS 1.2\Server" -Name 'Enabled' -Value '1' -PropertyType 'DWord' -Force | Out-Null
New-ItemProperty -Path $SChannelRegPath"\TLS 1.2\Server" -Name 'DisabledByDefault' -Value '0' -PropertyType 'DWord' -Force | Out-Null

If (-Not (Test-Path $SChannelRegPath"\TLS 1.2\Client"))
{
    New-Item $SChannelRegPath"\TLS 1.2\Client" -Force | Out-Null
}
New-ItemProperty -Path $SChannelRegPath"\TLS 1.2\Client" -Name 'Enabled' -Value '1' -PropertyType 'DWord' -Force | Out-Null
New-ItemProperty -Path $SChannelRegPath"\TLS 1.2\Client" -Name 'DisabledByDefault' -Value '0' -PropertyType 'DWord' -Force | Out-Null

If (-Not (Test-Path $SChannelRegPath"\TLS 1.2\Server"))
{
    New-Item $SChannelRegPath"\TLS 1.2\Server" -Force | Out-Null
}
New-ItemProperty -Path $SChannelRegPath"\TLS 1.2\Server" -Name 'Enabled' -Value '1' -PropertyType 'DWord' -Force | Out-Null
New-ItemProperty -Path $SChannelRegPath"\TLS 1.2\Server" -Name 'DisabledByDefault' -Value '0' -PropertyType 'DWord' -Force | Out-Null

If (-Not (Test-Path $SChannelRegPath"\TLS 1.2\Client"))
{
    New-Item $SChannelRegPath"\TLS 1.2\Client" -Force | Out-Null
}
New-ItemProperty -Path $SChannelRegPath"\TLS 1.2\Client" -Name 'Enabled' -Value '1' -PropertyType 'DWord' -Force | Out-Null
New-ItemProperty -Path $SChannelRegPath"\TLS 1.2\Client" -Name 'DisabledByDefault' -Value '0' -PropertyType 'DWord' -Force | Out-Null

Write-Host 'TLS 1.2 has been enabled. You must restart the Windows Server for the changes to take affect.' -ForegroundColor Cyan