## 📌 Overview

This script extracts failed authentication attempts and parses detailed fields
from the Windows Security log, including:

- Username & domain
- Failure reason & status codes
- Source IP address
- Logon type & process
- Timestamp

Designed for:
- Security auditing
- Incident response
- Brute-force detection
- Compliance reporting

---

## ✨ Features

- Parses Event ID **4625**
- Structured CSV output
- Timestamped reports
- No external dependencies
- Easy to customize or automate

---

## 📂 Output

CSV file is generated at: C:\Users\Admin\Desktop\FailedLogons-<date>.csv

---

## ▶️ Usage

1. Open PowerShell **as Administrator**
2. Run:

```powershell
.\Get-FailedLogons.ps1```

---

```<#
.SYNOPSIS
    Exports failed logon events (Event ID 4625) from the Windows Security log.

.DESCRIPTION
    Retrieves failed authentication attempts from the Security event log,
    parses relevant event fields, and exports the results to a CSV file.

    This script is useful for:
    - Security auditing
    - Incident response
    - Brute-force attack detection
    - Compliance reporting

.EXAMPLE
    .\Get-FailedLogons.ps1

.NOTES
    Requires:
    - PowerShell 5.1+
    - Administrative privileges
    - Access to the Security event log
#>

# Generate timestamp for output file
$date = Get-Date -Format "dd-MM-yyyy-HH"
$outputPath = "C:\Users\Admin\Desktop\FailedLogons-$date.csv"

# Retrieve failed logon events (Event ID 4625)
$events = Get-WinEvent -FilterHashtable @{
    LogName = 'Security'
    Id      = 4625
} -MaxEvents 10000

# Store parsed results
$parsedEvents = @()

foreach ($event in $events) {
    $xml  = [xml]$event.ToXml()
    $data = $xml.Event.EventData.Data

    $parsedEvents += [PSCustomObject]@{
        TimeCreated                = $event.TimeCreated
        SubjectUserSid            = $data[0].'#text'
        SubjectUserName           = $data[1].'#text'
        SubjectDomainName         = $data[2].'#text'
        SubjectLogonId            = $data[3].'#text'
        TargetUserSid             = $data[4].'#text'
        TargetUserName            = $data[5].'#text'
        TargetDomainName          = $data[6].'#text'
        Status                    = $data[7].'#text'
        FailureReason             = $data[8].'#text'
        SubStatus                 = $data[9].'#text'
        LogonType                 = $data[10].'#text'
        LogonProcessName          = $data[11].'#text'
        AuthenticationPackageName = $data[12].'#text'
        WorkstationName           = $data[13].'#text'
        ProcessId                 = $data[17].'#text'
        ProcessName               = $data[18].'#text'
        IpAddress                 = $data[19].'#text'
        IpPort                    = $data[20].'#text'
    }
}

# Export to CSV
$parsedEvents | Export-Csv -Path $outputPath -NoTypeInformation -Encoding UTF8

Write-Host "Export complete. File saved to $outputPath" -ForegroundColor Green```
