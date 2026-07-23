<#
.SYNOPSIS
Imports users into Active Directory from an Excel spreadsheet.

.DESCRIPTION
Creates user accounts, assigns groups, managers, and logs the import process.
#>

#requires -Modules ActiveDirectory,ImportExcel
Import-Module ActiveDirectory
Import-Module ImportExcel

$ExcelPath = ".\ThousifLab_Employees_250_Enterprise.xlsx"
$LogFile   = ".\ImportUsers.log"

if (!(Test-Path $ExcelPath)) {
    Write-Host "Excel file not found: $ExcelPath" -ForegroundColor Red
    exit
}

New-Item -ItemType Directory -Force -Path (Split-Path $LogFile) | Out-Null

function Write-Log {
    param([string]$Message)
    Add-Content $LogFile "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') $Message"
}

$Domain = Get-ADDomain
$DomainDN = $Domain.DistinguishedName
$Users = Import-Excel $ExcelPath

$Required = @(
"EmployeeID","FirstName","LastName","DisplayName","Username",
"Email","Department","Title","OU","SecurityGroup",
"Manager","Office","Company","Password","Enabled"
)

foreach($Col in $Required){
    if($Users[0].PSObject.Properties.Name -notcontains $Col){
        throw "Missing column: $Col"
    }
}

$Created=0
$Skipped=0
$Failed=0
$Total=$Users.Count
$Count=0

foreach($User in $Users){

    $Count++
    Write-Progress -Activity "Importing Users" -Status "$Count of $Total" -PercentComplete (($Count/$Total)*100)

    $TargetOU="$($User.OU),$DomainDN"

    if(!(Get-ADOrganizationalUnit -LDAPFilter "(distinguishedName=$TargetOU)" -ErrorAction SilentlyContinue)){
        Write-Host "[OU MISSING] $TargetOU" -ForegroundColor Yellow
        Write-Log "OU Missing: $TargetOU"
        $Failed++
        continue
    }

    if(Get-ADUser -LDAPFilter "(sAMAccountName=$($User.Username))" -ErrorAction SilentlyContinue){
        Write-Host "[SKIPPED] $($User.Username)" -ForegroundColor Yellow
        $Skipped++
        continue
    }

    $BaseName=$User.DisplayName
    if([string]::IsNullOrWhiteSpace($BaseName)){
        $BaseName="$($User.FirstName) $($User.LastName)"
    }

    $UniqueName=$BaseName
    $Suffix=2

    while(Get-ADObject -LDAPFilter "(cn=$UniqueName)" -SearchBase $TargetOU -ErrorAction SilentlyContinue){
        $UniqueName="$BaseName ($Suffix)"
        $Suffix++
    }

    if([string]::IsNullOrWhiteSpace($User.Password)){
        $Pwd=ConvertTo-SecureString "ChangeMe123!" -AsPlainText -Force
    } else {
        $Pwd=ConvertTo-SecureString $User.Password -AsPlainText -Force
    }

    $Enabled=$false
    if("$($User.Enabled)".ToLower() -eq "true"){$Enabled=$true}

    try{

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

        if($User.SecurityGroup){
            try{
                Add-ADGroupMember -Identity $User.SecurityGroup -Members $User.Username -ErrorAction Stop
            }catch{
                Write-Log "Group assignment failed for $($User.Username): $_"
            }
        }

        if($User.Manager){
            try{
                $Mgr=Get-ADUser -LDAPFilter "(sAMAccountName=$($User.Manager))" -ErrorAction Stop
                Set-ADUser $User.Username -Manager $Mgr.DistinguishedName
            }catch{
                Write-Log "Manager assignment skipped for $($User.Username)"
            }
        }

        Write-Host "[CREATED] $($User.Username)" -ForegroundColor Green
        Write-Log "Created $($User.Username)"
        $Created++
    }
    catch{
        Write-Host "[FAILED] $($User.Username)" -ForegroundColor Red
        Write-Host $_.Exception.Message -ForegroundColor Red
        Write-Log "Failed $($User.Username): $($_.Exception.Message)"
        $Failed++
    }
}

Write-Progress -Activity "Importing Users" -Completed
Write-Host ""
Write-Host "========== SUMMARY ==========" -ForegroundColor Cyan
Write-Host "Created : $Created"
Write-Host "Skipped : $Skipped"
Write-Host "Failed  : $Failed"
