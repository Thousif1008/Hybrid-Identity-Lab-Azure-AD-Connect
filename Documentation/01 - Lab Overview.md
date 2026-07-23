\# Lab Overview



\## Overview



This project documents the creation of a hybrid identity lab using Windows Server 2022, Active Directory Domain Services, Microsoft Entra ID, Microsoft Entra Connect, and Microsoft 365.



The lab was built in VMware Workstation Pro to simulate an on-premises Active Directory environment integrated with Microsoft Entra ID. Microsoft Entra Connect was configured to synchronize users, groups, password hashes, and selected attributes between the on-premises domain and the cloud.



The project also includes testing, PowerShell administration, synchronization verification, troubleshooting, and documentation for each stage of the setup.



!\[Hybrid Identity Lab Architecture](../01%20-%20Architecture/Hybrid\_Identity\_Lab\_Architecture.png)



\---



\## Lab Environment



The lab consists of one Windows Server 2022 domain controller and one Windows 11 client connected to a Microsoft Entra tenant. The environment uses Password Hash Synchronization (PHS) to provide a hybrid identity solution.



\### Components



\- VMware Workstation Pro

\- Windows Server 2022

\- Windows 11 Pro

\- Active Directory Domain Services (AD DS)

\- DNS Server

\- Group Policy

\- File Server

\- Microsoft Entra ID

\- Microsoft Entra Connect

\- Microsoft 365



!\[VMware Workstation](../04%20-%20Screenshots/12%20-%20Prerequisites/01\_VMware\_Workstation.png)



\---



\## Active Directory



An on-premises Active Directory domain was configured with organizational units, users, security groups, and Group Policy. The Windows 11 client was joined to the domain to test authentication and management.



!\[Department Users](../04%20-%20Screenshots/02%20-%20Active%20Directory/03\_Department\_Users.png)



\---



\## Microsoft Entra ID



Microsoft Entra Connect synchronizes objects from Active Directory to Microsoft Entra ID. After synchronization, users can authenticate with the same identity in both the on-premises environment and Microsoft 365.



!\[Microsoft Entra Users After Initial Sync](../04%20-%20Screenshots/05%20-%20Synchronization/01\_Entra\_Users\_After\_Initial\_Sync.png)



\---



\## What This Project Covers



\- Building an Active Directory domain

\- Configuring DNS and Group Policy

\- Joining a Windows 11 client to the domain

\- Installing and configuring Microsoft Entra Connect

\- Synchronizing users, groups, password hashes, and attributes

\- Verifying synchronization in Microsoft Entra ID

\- Testing hybrid identity sign-in

\- Running synchronization with PowerShell

\- Troubleshooting common synchronization issues



\---



\## Summary



This lab provides hands-on experience with a hybrid identity environment by combining on-premises Active Directory with Microsoft Entra ID and Microsoft 365. Each part of the project is documented separately, covering the configuration process, synchronization, testing, PowerShell commands, troubleshooting, and lessons learned.

