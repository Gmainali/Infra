# Get-DailyFileCount.ps1

Counts the number of CSV files created (or modified) each day in a specified directory and generates a daily summary report.

## 📌 Overview

This PowerShell script scans a given folder for CSV files and groups them by date, showing how many files were created per day. It’s useful for:

- Monitoring daily file generation
- Identifying trends or spikes in CSV output
- Creating simple audit or activity reports

A CSV report is also automatically generated for further analysis.

## ✨ Features

- Scans a specified directory for CSV files  
- Groups files by **creation date**
- Displays a formatted daily summary in the console
- Exports results to a CSV report
- Simple and dependency-free

## 📂 Script Details

- **File:** `Get-DailyFileCount.ps1`
- **Language:** PowerShell
- **Output:** Console table + CSV report

## 🔧 Parameters

| Parameter | Required | Description |
|---------|----------|-------------|
| `Path`  | Yes      | Path to the directory containing CSV files |

## ▶️ Usage

```powershell
<#
.SYNOPSIS
    Counts CSV files per day in a specified directory.

.DESCRIPTION
    Scans a directory for CSV files and groups them by creation date.
    Outputs a daily summary table and exports results to CSV.

.PARAMETER Path
    The directory path to scan for CSV files.

.EXAMPLE
    .\Get-DailyFileCount.ps1 -Path "C:\Invoices"

.EXAMPLE
    # Run against a network share
    .\Get-DailyFileCount.ps1 -Path "\\Server01\Exports"

.NOTES
    Author: Your Name
    Requires: PowerShell 5.1+
#>

param (
    [Parameter(Mandatory = $true)]
    [string]$Path
)

# Validate the provided path
if (-not (Test-Path $Path)) {
    Write-Error "Path not found: $Path"
    exit 1
}

# Retrieve CSV files in the target directory
$files = Get-ChildItem -Path $Path -File -Filter *.CSV

# Exit if no files are found
if ($files.Count -eq 0) {
    Write-Host "No CSV files found in the specified path."
    exit 0
}

# Group files by creation date
$dailyCounts = $files |
    Group-Object { $_.CreationTime.Date } |
    Select-Object `
        @{ Name = "Date"; Expression = { $_.Name } },
        @{ Name = "FileCount"; Expression = { $_.Count } } |
    Sort-Object Date

# Display formatted output
Write-Host "`n📅 Daily CSV File Count Summary`n" -ForegroundColor Cyan
$dailyCounts | Format-Table -AutoSize

# Export results to CSV
$csvPath = Join-Path $Path "DailyFileCount_Report.csv"
$dailyCounts | Export-Csv -Path $csvPath -NoTypeInformation

Write-Host "`nReport saved to: $csvPath" -ForegroundColor Green```



## 📅 Sample Output

Date        FileCount
----        ---------
2024-09-01  12
2024-09-02  18
2024-09-03  7

