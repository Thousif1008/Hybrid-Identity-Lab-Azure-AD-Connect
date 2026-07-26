<#
.SYNOPSIS
Imports users into Active Directory from an Excel spreadsheet.

.DESCRIPTION
Creates user accounts, assigns groups, sets managers, and logs the import process.
Supports -WhatIf so the import can be dry-run before making changes.

.PARAMETER ExcelPath
Path to the source Excel workbook containing user data.

.PARAMETER LogFolder
Folder where the run log and failure report will be written. Created if missing.

.PARAMETER DefaultPassword
Fallback password used only when a row has no Password value. Ignored if
-RandomizePassword is used, which is the safer default behavior.

.PARAMETER RandomizePassword
When set (default: $true), generates a random password per user instead of
using DefaultPassword or a plaintext value from the spreadsheet. Randomly
generated passwords are written to the failure/summary report so they can
be retrieved once, then the report should be deleted or secured.

.EXAMPLE
.\Import-EnterpriseUsers-XLSX.ps1 -ExcelPath ".\Employees.xlsx" -WhatIf

.EXAMPLE
.\Import-EnterpriseUsers-XLSX.ps1 -ExcelPath ".\Employees.xlsx"
#>

[CmdletBinding(SupportsShouldProcess = $true)]
param(
    [Parameter(Mandatory = $false)]
    [string]$ExcelPath = ".\ThousifLab_Employees_250_Enterprise.xlsx",

    [Parameter(Mandatory = $false)]
    [string]$LogFolder = ".\Logs",

    [Parameter(Mandatory = $false)]
    [string]$DefaultPassword = "ChangeMe123!",

    [Parameter(Mandatory = $false)]
    [bool]$RandomizePassword = $true
)

#requires -Modules ActiveDirectory,ImportExcel
Import-Module ActiveDirectory
Import-Module ImportExcel

# ---------------------------------------------------------------------------
# Setup
# ---------------------------------------------------------------------------

if (!(Test-Path $ExcelPath)) {
    Write-Host "Excel file not found: $ExcelPath" -ForegroundColor Red
    exit 1
}

if (!(Test-Path $LogFolder)) {
    New-Item -ItemType Directory -Force -Path $LogFolder | Out-Null
}

$RunStamp   = Get-Date -Format 'yyyy-MM-dd_HHmmss'
$LogFile    = Join-Path $LogFolder "ImportUsers_$RunStamp.log"
$ReportFile = Join-Path $LogFolder "ImportUsers_$RunStamp`_Report.csv"
$Report     = New-Object System.Collections.Generic.List[object]

function Write-Log {
    param([string]$Message)
    Add-Content -Path $LogFile -Value "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') $Message"
}

function New-RandomPassword {
    # Generates a password that satisfies typical AD complexity requirements:
    # upper, lower, digit, special character, 12+ characters.
    $upper   = 65..90  | Get-Random -Count 3 | ForEach-Object { [char]$_ }
    $lower   = 97..122 | Get-Random -Count 3 | ForEach-Object { [char]$_ }
    $digits  = 48..57  | Get-Random -Count 3 | ForEach-Object { [char]$_ }
    $special = '!@#$%^&*'.ToCharArray() | Get-Random -Count 3
    -join (($upper + $lower + $digits + $special) | Get-Random -Count 12)
}

$Domain   = Get-ADDomain
$DomainDN = $Domain.DistinguishedName
$Users    = @(Import-Excel $ExcelPath)

if ($Users.Count -eq 0) {
    Write-Host "No rows found in $ExcelPath - nothing to import." -ForegroundColor Red
    exit 1
}

$Required = @(
    "EmployeeID","FirstName","LastName","DisplayName","Username",
    "Email","Department","Title","OU","SecurityGroup",
    "Manager","Office","Company","Password","Enabled"
)

foreach ($Col in $Required) {
    if ($Users[0].PSObject.Properties.Name -notcontains $Col) {
        throw "Missing column: $Col"
    }
}

$Created = 0
$Skipped = 0
$Failed  = 0
$Total   = $Users.Count
$Count   = 0

Write-Log "===== Import started: $Total rows from $ExcelPath ====="

# ---------------------------------------------------------------------------
# Main import loop
# ---------------------------------------------------------------------------

foreach ($User in $Users) {

    $Count++
    Write-Progress -Activity "Importing Users" -Status "$Count of $Total" -PercentComplete (($Count / $Total) * 100)

    $TargetOU = "$($User.OU),$DomainDN"

    # --- Validate target OU exists ---
    try {
        $OUExists = Get-ADOrganizationalUnit -LDAPFilter "(distinguishedName=$TargetOU)" -ErrorAction Stop
    }
    catch {
        Write-Host "[OU LOOKUP ERROR] $TargetOU - $($_.Exception.Message)" -ForegroundColor Red
        Write-Log "OU lookup error for $($User.Username): $($_.Exception.Message)"
        $Report.Add([pscustomobject]@{ Username = $User.Username; Status = "Failed"; Reason = "OU lookup error"; Password = "" })
        $Failed++
        continue
    }

    if (-not $OUExists) {
        Write-Host "[OU MISSING] $TargetOU" -ForegroundColor Yellow
        Write-Log "OU Missing: $TargetOU"
        $Report.Add([pscustomobject]@{ Username = $User.Username; Status = "Failed"; Reason = "OU missing"; Password = "" })
        $Failed++
        continue
    }

    # --- Skip if user already exists ---
    if (Get-ADUser -LDAPFilter "(sAMAccountName=$($User.Username))" -ErrorAction SilentlyContinue) {
        Write-Host "[SKIPPED] $($User.Username)" -ForegroundColor Yellow
        Write-Log "Skipped (already exists): $($User.Username)"
        $Report.Add([pscustomobject]@{ Username = $User.Username; Status = "Skipped"; Reason = "Already exists"; Password = "" })
        $Skipped++
        continue
    }

    # --- Resolve display name and avoid CN collisions ---
    $BaseName = $User.DisplayName
    if ([string]::IsNullOrWhiteSpace($BaseName)) {
        $BaseName = "$($User.FirstName) $($User.LastName)"
    }

    $UniqueName = $BaseName
    $Suffix = 2

    try {
        # Get-ADObject with a filter returns $null (not an error) when there's
        # no match, so the while loop exits normally once the name is unique.
        # The try/catch here only guards against real failures (e.g. the
        # domain controller being unreachable) partway through the loop.
        while (Get-ADObject -LDAPFilter "(cn=$UniqueName)" -SearchBase $TargetOU -ErrorAction Stop) {
            $UniqueName = "$BaseName ($Suffix)"
            $Suffix++
        }
    }
    catch {
        Write-Log "Error checking name collisions for $($User.Username): $($_.Exception.Message)"
    }

    # --- Password handling ---
    $PlainPassword = $null
    if ($RandomizePassword) {
        $PlainPassword = New-RandomPassword
    }
    elseif (-not [string]::IsNullOrWhiteSpace($User.Password)) {
        $PlainPassword = $User.Password
    }
    else {
        $PlainPassword = $DefaultPassword
    }
    $Pwd = ConvertTo-SecureString $PlainPassword -AsPlainText -Force

    $Enabled = $false
    if ("$($User.Enabled)".Trim().ToLower() -eq "true") { $Enabled = $true }

    # --- Create the user ---
    if ($PSCmdlet.ShouldProcess($User.Username, "Create AD user")) {
        try {
            New-ADUser `
                -Name $UniqueName `
                -DisplayName $BaseName `
                -GivenName $User.FirstName `
                -Surname $User.LastName `
                -SamAccountName $User.Username `
                -UserPrincipalName "$($User.Username)@$($Domain.DNSRoot)" `
                -EmailAddress $User.Email `
                -Department $User.Department `
                -Title $User.Title `
                -Office $User.Office `
                -Company $User.Company `
                -Path $TargetOU `
                -AccountPassword $Pwd `
                -Enabled $Enabled `
                -ChangePasswordAtLogon $true

            if ($User.SecurityGroup) {
                try {
                    Add-ADGroupMember -Identity $User.SecurityGroup -Members $User.Username -ErrorAction Stop
                }
                catch {
                    Write-Log "Group assignment failed for $($User.Username): $($_.Exception.Message)"
                }
            }

            if ($User.Manager) {
                try {
                    $Mgr = Get-ADUser -LDAPFilter "(sAMAccountName=$($User.Manager))" -ErrorAction Stop
                    Set-ADUser $User.Username -Manager $Mgr.DistinguishedName
                }
                catch {
                    Write-Log "Manager assignment skipped for $($User.Username): $($_.Exception.Message)"
                }
            }

            Write-Host "[CREATED] $($User.Username)" -ForegroundColor Green
            Write-Log "Created $($User.Username)"
            $Report.Add([pscustomobject]@{
                Username = $User.Username
                Status   = "Created"
                Reason   = ""
                Password = if ($RandomizePassword) { $PlainPassword } else { "" }
            })
            $Created++
        }
        catch {
            Write-Host "[FAILED] $($User.Username)" -ForegroundColor Red
            Write-Host $_.Exception.Message -ForegroundColor Red
            Write-Log "Failed $($User.Username): $($_.Exception.Message)"
            $Report.Add([pscustomobject]@{ Username = $User.Username; Status = "Failed"; Reason = $_.Exception.Message; Password = "" })
            $Failed++
        }
    }
}

Write-Progress -Activity "Importing Users" -Completed

# ---------------------------------------------------------------------------
# Summary
# ---------------------------------------------------------------------------

$Report | Export-Csv -Path $ReportFile -NoTypeInformation
Write-Log "===== Import finished. Created=$Created Skipped=$Skipped Failed=$Failed ====="

Write-Host ""
Write-Host "========== SUMMARY ==========" -ForegroundColor Cyan
Write-Host "Created : $Created"
Write-Host "Skipped : $Skipped"
Write-Host "Failed  : $Failed"
Write-Host ""
Write-Host "Log file    : $LogFile"
Write-Host "Report file : $ReportFile" -ForegroundColor Yellow
if ($RandomizePassword) {
    Write-Host "NOTE: Report file contains generated plaintext passwords for new users." -ForegroundColor Yellow
    Write-Host "      Distribute securely and delete/secure the report after use." -ForegroundColor Yellow
}