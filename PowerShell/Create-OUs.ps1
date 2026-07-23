<#
.SYNOPSIS
Creates the Organizational Unit structure for the Active Directory homelab.

.DESCRIPTION
Creates the Enterprise parent OU along with child OUs for Users,
Computers, Groups, Service Accounts, and Resources.
#>

Import-Module ActiveDirectory

# Automatically detect the domain
$DomainDN = (Get-ADDomain).DistinguishedName

# Parent OU
$EnterpriseOU = "OU=Enterprise,$DomainDN"

# Create Enterprise OU if it doesn't exist
if (-not (Get-ADOrganizationalUnit -LDAPFilter "(ou=Enterprise)" -SearchBase $DomainDN -ErrorAction SilentlyContinue)) {
    New-ADOrganizationalUnit -Name "Enterprise" -Path $DomainDN
}

# Top-level OUs
$TopLevelOUs = @(
    "Users",
    "Computers",
    "Groups",
    "Service Accounts",
    "Resources"
)

foreach ($OU in $TopLevelOUs) {
    if (-not (Get-ADOrganizationalUnit -LDAPFilter "(ou=$OU)" -SearchBase $EnterpriseOU -ErrorAction SilentlyContinue)) {
        New-ADOrganizationalUnit -Name $OU -Path $EnterpriseOU
    }
}

# Child OUs under Users
$UsersOU = "OU=Users,$EnterpriseOU"

$UserOUs = @(
    "IT",
    "HR",
    "Finance",
    "Sales",
    "Management"
)

foreach ($OU in $UserOUs) {
    if (-not (Get-ADOrganizationalUnit -LDAPFilter "(ou=$OU)" -SearchBase $UsersOU -ErrorAction SilentlyContinue)) {
        New-ADOrganizationalUnit -Name $OU -Path $UsersOU
    }
}

# Child OUs under Computers
$ComputersOU = "OU=Computers,$EnterpriseOU"

$ComputerOUs = @(
    "Servers",
    "Workstations"
)

foreach ($OU in $ComputerOUs) {
    if (-not (Get-ADOrganizationalUnit -LDAPFilter "(ou=$OU)" -SearchBase $ComputersOU -ErrorAction SilentlyContinue)) {
        New-ADOrganizationalUnit -Name $OU -Path $ComputersOU
    }
}

# Child OUs under Groups
$GroupsOU = "OU=Groups,$EnterpriseOU"

$GroupOUs = @(
    "Security Groups",
    "Distribution Groups"
)

foreach ($OU in $GroupOUs) {
    if (-not (Get-ADOrganizationalUnit -LDAPFilter "(ou=$OU)" -SearchBase $GroupsOU -ErrorAction SilentlyContinue)) {
        New-ADOrganizationalUnit -Name $OU -Path $GroupsOU
    }
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host " Enterprise OU structure created!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green