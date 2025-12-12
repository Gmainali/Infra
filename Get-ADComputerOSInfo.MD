# Active Directory Computer OS Export Script

This PowerShell script retrieves the **Operating System** and **OS Version** of computers listed in a CSV file by querying Active Directory. The results are exported into a new CSV file.

---

## 📋 Prerequisites
- Windows PowerShell
- Active Directory module installed (`Import-Module ActiveDirectory`)
- A CSV file (`computer.csv`) containing computer names with a column header `Name`

---

## 🚀 Script

```powershell
Import-Module ActiveDirectory

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

---

📂 Input File Example (computer.csv)

```csv
Name
PC001
PC002
PC003```

---

📂 Output File Example (computer1.csv)
```csv
"ComputerName","OperatingSystem","OSVersion"
"PC001","Windows 10 Pro","10.0 (19045)"
"PC002","Windows Server 2019 Standard","10.0 (17763)"
"PC003","Not found","Not found"```

---

## ✅ Usage
- Place your computer.csv file in C:\temp\.
- Run the PowerShell script.
- Check C:\temp\computer1.csv for the exported results.

---

## 📝 Notes
- Ensure you have Active Directory permissions to query computer objects.
- If a computer is not found in AD, the script will mark it as "Not found".

---

