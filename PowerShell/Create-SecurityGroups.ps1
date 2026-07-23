<#
.SYNOPSIS
Creates security and distribution groups for the Active Directory homelab.

.DESCRIPTION
Creates departmental security groups, administrative groups,
and distribution groups inside the Enterprise OU structure.
#>

Import-Module ActiveDirectory

# Detect domain automatically
$DomainDN = (Get-ADDomain).DistinguishedName

# OUs
$SecurityOU = "OU=Security Groups,OU=Groups,OU=Enterprise,$DomainDN"
$DistributionOU = "OU=Distribution Groups,OU=Groups,OU=Enterprise,$DomainDN"
$AdminOU = "OU=Administrative Groups,OU=Groups,OU=Enterprise,$DomainDN"

# Create Administrative Groups OU if it doesn't exist
if (-not (Get-ADOrganizationalUnit -LDAPFilter "(ou=Administrative Groups)" -SearchBase "OU=Groups,OU=Enterprise,$DomainDN" -ErrorAction SilentlyContinue))
{
    New-ADOrganizationalUnit -Name "Administrative Groups" -Path "OU=Groups,OU=Enterprise,$DomainDN"
}

# Department Security Groups
$SecurityGroups = @(
    "GG_IT",
    "GG_HR",
    "GG_Finance",
    "GG_Sales",
    "GG_Management"
)

foreach ($Group in $SecurityGroups)
{
    if (-not (Get-ADGroup -LDAPFilter "(cn=$Group)" -SearchBase $SecurityOU -ErrorAction SilentlyContinue))
    {
        New-ADGroup `
            -Name $Group `
            -SamAccountName $Group `
            -GroupScope Global `
            -GroupCategory Security `
            -Path $SecurityOU `
            -Description "$Group Department Security Group"

        Write-Host "[+] Created $Group" -ForegroundColor Green
    }
}

# Administrative Security Groups
$AdminGroups = @(
    "GG_Helpdesk",
    "GG_Server_Admins",
    "GG_Domain_Admins"
)

foreach ($Group in $AdminGroups)
{
    if (-not (Get-ADGroup -LDAPFilter "(cn=$Group)" -SearchBase $AdminOU -ErrorAction SilentlyContinue))
    {
        New-ADGroup `
            -Name $Group `
            -SamAccountName $Group `
            -GroupScope Global `
            -GroupCategory Security `
            -Path $AdminOU `
            -Description "$Group Administrative Security Group"

        Write-Host "[+] Created $Group" -ForegroundColor Green
    }
}

# Distribution Groups
$DistributionGroups = @(
    "DG_IT",
    "DG_HR",
    "DG_Finance",
    "DG_Sales",
    "DG_Management"
)

foreach ($Group in $DistributionGroups)
{
    if (-not (Get-ADGroup -LDAPFilter "(cn=$Group)" -SearchBase $DistributionOU -ErrorAction SilentlyContinue))
    {
        New-ADGroup `
            -Name $Group `
            -SamAccountName $Group `
            -GroupScope Universal `
            -GroupCategory Distribution `
            -Path $DistributionOU `
            -Description "$Group Distribution Group"

        Write-Host "[+] Created $Group" -ForegroundColor Green
    }
}

Write-Host ""
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host " Group creation completed." -ForegroundColor Green
Write-Host "==========================================" -ForegroundColor Cyan