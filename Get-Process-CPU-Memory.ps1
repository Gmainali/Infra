# PowerShell Script: Monitor `diawp` Process Memory and CPU

This repository contains a **PowerShell script** to monitor all instances of the `diawp` process and report CPU usage and multiple memory metrics, including **Working Set, Commit, Private, and Shareable memory**. It also includes a timestamp for when the script was run.

---
## Features
- Lists **all running `diawp` processes**
- Shows **PID**, **CPU**, and **memory usage** in MB
- Reports **multiple memory metrics** matching Resource Monitor and Task Manager
- Includes **timestamp** for logging purposes

---
## Memory Types

| Memory Type        | PowerShell Property          | Description                                                | Matches                                     |
|-------------------|-----------------------------|------------------------------------------------------------|---------------------------------------------|
| Working Set (KB)   | `WorkingSet64`              | Total physical RAM currently used by the process, including private and shareable memory | Resource Monitor “Working Set”             |
| Commit (KB)        | `PrivateMemorySize64`       | Virtual memory reserved for the process                     | Resource Monitor “Commit”                   |
| Private (KB)       | `WorkingSetPrivate` (WMI)  | Memory used **only by this process** and cannot be shared | Task Manager “Memory” + Resource Monitor “Private” |
| Shareable (KB)     | `WorkingSet64 - WorkingSetPrivate` | Memory that can potentially be shared with other processes (e.g., DLLs) | Resource Monitor “Shareable”               |

> Note: `PrivateWorkingSet` via WMI may not be available for all processes. In those cases, it will display `"N/A"`.

---
## Script Usage

```powershell
$proc = "diawp"
$plist = Get-Process -Name $proc -ErrorAction SilentlyContinue

if (-not $plist) {
    Write-Host "Process not found."
    return
}

$result = foreach ($p in $plist) {

    # Get WMI row for this exact PID
    $wmi = Get-WmiObject Win32_PerfFormattedData_PerfProc_Process -ErrorAction SilentlyContinue |
           Where-Object { $_.IDProcess -eq $p.Id } |
           Select-Object -First 1

    [PSCustomObject]@{
        DateTime               = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
        Name                   = $p.Name
        PID                    = $p.Id
        WorkingSet_MB          = "{0:N2}" -f ($p.WorkingSet64 / 1MB)
        PrivateMemorySize_MB   = "{0:N2}" -f ($p.PrivateMemorySize64 / 1MB)
        PrivateWorkingSet_MB   = if ($wmi) {
                                     "{0:N2}" -f ($wmi.WorkingSetPrivate / 1MB)
                                 } else {
                                     "N/A"
                                 }
        CPU                    = "{0:N2}" -f $p.CPU
    }
}

$result | Format-Table -AutoSize


## Example Output
DateTime            Name   PID   WorkingSet_MB PrivateMemorySize_MB PrivateWorkingSet_MB CPU
--------            ----   ---   ------------- -------------------- --------------------- ---
2025-12-09 14:25:01 diawp 3096  78.44         52.10                28.80                1.98
2025-12-09 14:25:01 diawp 4100  12.33         10.15                8.90                 0.55


## Notes:
- The script automatically handles multiple diawp processes.
  - CPU values are limited to two decimal places.
  - For processes where WMI does not provide WorkingSetPrivate, the script displays "N/A".
  - Memory values are reported in MB, formatted to 2 decimal places for readability.
