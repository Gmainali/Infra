# Batch File Deletion in PowerShell

This repository contains two scripts for deleting large numbers of files in batches using PowerShell. Both scripts are designed to prevent VM overload by processing a fixed number of files at a time with optional pauses between batches.

---

## Scripts Overview

### 1️⃣ Script Using `Get-ChildItem`

```powershell
$Path      = "C:\Temp\Logs"
$BatchSize = 2500
$PauseSec  = 15

while ($true) {
    $Batch = Get-ChildItem $Path -File -Recurse -ErrorAction SilentlyContinue |
             Select-Object -First $BatchSize
    if (-not $Batch) {
        break
    }
    foreach ($File in $Batch) {
        Remove-Item $File.FullName -Force
    }
    Start-Sleep -Seconds $PauseSec
}
Write-Host "All files deleted in controlled batches."
```

---

## Description:
This script uses PowerShell’s native Get-ChildItem to enumerate files as objects (FileInfo) and deletes them in batches with a pause to reduce system load.

Pros:
- Provides rich file metadata (Name, FullName, Length, LastWriteTime).
- Easy to customize for filtering (e.g., by date, extension).
- Works well for small to medium directories.

Cons:
- Slower for millions of files due to object creation overhead.
- Uses more memory than necessary for large directories.
- Enumeration may take time before batch deletion starts.

### 1️⃣ Script Using [System.IO.Directory]::EnumerateFiles()

```$Path = "C:\Temp\Logs"
$BatchSize = 2500
$PauseSec = 3

while ($true) {
    $Batch = [System.IO.Directory]::EnumerateFiles($Path, "*", [System.IO.SearchOption]::AllDirectories) |
             Select-Object -First $BatchSize

    if (-not $Batch) { break }

    foreach ($File in $Batch) { Remove-Item $File -Force }

    Start-Sleep $PauseSec
}
```

---

## Description:
This script uses the .NET EnumerateFiles() method to stream file paths as strings and deletes them in batches. It is more memory-efficient and faster on very large directories.

Pros:
- Extremely fast and low memory usage.
- True streaming, stops enumeration immediately after batch.
- Handles millions of files efficiently.
- VM-friendly due to reduced memory and CPU usage.

Cons:
- Returns string paths only, so no immediate file metadata.
- Slightly less flexible if you need properties like CreationTime or Length.
- Cannot filter easily by file properties without additional code.


---

## Comparison Summary
Feature	                  Get-ChildItem Script	        EnumerateFiles() Script
File enumeration	        FileInfo objects	            String paths
Memory usage	            Higher	                      Low
Speed for millions	      Slower	                      Much faster
Metadata access	          Immediate	                    Requires FileInfo wrapper
Streaming & batching	    Partial	                      True streaming
VM-friendly	              Medium	                      High
Filtering capabilities	  Easy	                        Slightly more work


---

## Recommendations

Use Get-ChildItem if:
- Directory size is moderate.
- You need file metadata.
- You want to filter files by date, size, or extension easily.
- Use [System.IO.Directory]::EnumerateFiles() if:
- Directory contains hundreds of thousands or millions of files.
- Memory and VM load are critical.
- You only need to delete files by path without metadata.

---

## Cleaning Old Files in System and Log Folders

This example demonstrates how to delete files older than a specified number of days in a folder. You can use it for temporary files, logs, or browser caches.

```# Delete all files older than 150 days
$Path = "E:\Logs"
$Daysback = -150
$CurrentDate = Get-Date
$DatetoDelete = $CurrentDate.AddDays($Daysback)

Get-ChildItem $Path | Where-Object { $_.LastWriteTime -lt $DatetoDelete } | Remove-Item
```

# Cache folder
- C:\Windows\SysWOW64\config\systemprofile\AppData\Local\Microsoft\Windows\INetCache\IE
- C:\Windows\System32\config\systemprofile\AppData\Local\Microsoft\Windows\INetCache\IE
- C:\Users\Svc-Account\AppData\Local\Microsoft\Windows\INetCache\IE

Notes:
* $Path can point to any folder, e.g., the Internet Explorer cache folder: This allows cleaning browser cache for the system profile.
* $Daysback defines how old a file must be to be deleted.
* Remove-Item deletes the files permanently, so test with a dry run first:

```Get-ChildItem $Path | Where-Object { $_.LastWriteTime -lt $DatetoDelete } | 
ForEach-Object { Write-Host "Would delete: $($_.FullName)" }
```

* Useful for log rotation, cleanup scripts, or system maintenance.

---

## Native Command Processor
# Remove files older than 150 days

forfiles /p "C:\Temp\Logs" /s /d -150 /c "cmd /c del /f /q @path"

---

## Create Dummy Files for Testing
```$Path = "C:\Temp\Logs"
New-Item -ItemType Directory -Force -Path $Path | Out-Null

1..20000 | ForEach-Object {
    New-Item -Path "$Path\file1_$_.log" -ItemType File | Out-Null
}
```
