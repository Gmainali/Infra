📘 Get-ADComputerOSInfo
##📝 Description

Get-ADComputerOSInfo is a PowerShell script that:
- Imports a CSV file containing computer names
- Queries Active Directory for each computer’s Operating System and version
- Exports the results to a new CSV report
- This is useful for OS inventory, audit reports, migration planning, and compliance tracking.

##📁 CSV Input Format

Your input CSV must contain a column named Name:
```Name
PC001
PC002
PC003```

Place it at:
C:\temp\computer.csv

##⚙️ Requirements
- Windows PowerShell 5.1 or PowerShell 7 with AD module
- ActiveDirectory module installed
- Import-Module ActiveDirectory
- Permissions to read Active Directory computer objects

##▶️ Usage
Run the script:
💻 Script: Get-ADComputerOSInfo.ps1

```Import-Module ActiveDirectory
# Import CSV with computer names
$computers = Import-Csv -Path "C:\temp\computer.csv"

# Loop through each computer and get its OS version from Active Directory
$results = foreach ($c in $computers) {

    $computerAD = Get-ADComputer -Identity $c.Name -Properties OperatingSystem, OperatingSystemVersion

    if ($computerAD) {
        [PSCustomObject]@{
            ComputerName    = $c.Name
            OperatingSystem = $computerAD.OperatingSystem
            OSVersion       = $computerAD.OperatingSystemVersion
        }
    }
    else {
        [PSCustomObject]@{
            ComputerName    = $c.Name
            OperatingSystem = "Not found"
            OSVersion       = "Not found"
        }
    }
}

# Export results to CSV
$results | Export-Csv -Path "C:\temp\computer1.csv" -NoTypeInformation

Write-Host "Export complete"```

##📤 Output
The script generates:
- C:\temp\computer1.csv


##Example output:
```ComputerName,OperatingSystem,OSVersion
PC001,Windows 10 Pro,10.0.19045
PC002,Windows 11 Enterprise,10.0.22631
PC003,Not found,Not found```

##📌 Notes
- Computers missing from AD will be labeled "Not found".
- You can add more AD properties if needed (LastLogonDate, ServicePack, etc.).
- Works in domain-joined environments only.
