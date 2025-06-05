<#
.SYNOPSIS
    This script Removes SSL and TLS hive from registry. So edit the script and unhash what is only required to be removed.
    Also a reboot is mandatory when Local Machine hive if modified.

.NOTES
    Author: Gyan Mainali
#>

#$SChannelRegPathSSL2 = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 2.0"
#$SChannelRegPathSSL3 = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 3.0"
#$SChannelRegPathTLS1 = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0"
#$SChannelRegPathTLS11 = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1"
#$SChannelRegPathTLS12 = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2"


If (Test-Path $SChannelRegPathSSL2){
    Remove-Item –Path $SChannelRegPathSSL2 -Recurse
    Write-Host $SChannelRegPathSSL2.Split('\')[-1] 'Server hardening has been removed.' -ForegroundColor Cyan
}

If (Test-Path $SChannelRegPathSSL3){
    Remove-Item –Path $SChannelRegPathSSL3 -Recurse
    Write-Host $SChannelRegPathSSL3.Split('\')[-1] 'Server hardening has been removed.' -ForegroundColor Cyan
}

If (Test-Path $SChannelRegPathTLS1){
    Remove-Item –Path $SChannelRegPathTLS1 -Recurse
    Write-Host $SChannelRegPathTLS1.Split('\')[-1] 'Server hardening has been removed.' -ForegroundColor Cyan
}

If (Test-Path $SChannelRegPathTLS11){
    Remove-Item –Path $SChannelRegPathTLS11 -Recurse
    Write-Host $SChannelRegPathTLS11.Split('\')[-1] 'Server hardening has been removed.' -ForegroundColor Cyan
}

If (Test-Path $SChannelRegPathTLS12){
    Remove-Item –Path $SChannelRegPathTLS12 -Recurse
    Write-Host $SChannelRegPathTLS12.Split('\')[-1] 'Server hardening has been removed.' -ForegroundColor Cyan
}

