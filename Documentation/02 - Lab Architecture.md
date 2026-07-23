# Lab Architecture



## Overview



This lab uses a hybrid identity environment with an on-premises Active Directory domain and Microsoft Entra ID. Microsoft Entra Connect synchronizes identities from Active Directory to Microsoft Entra ID, allowing users to sign in to Microsoft 365 with their synchronized accounts.



![Hybrid Identity Lab Architecture](../01%20-%20Architecture/Hybrid_Identity_Lab_Architecture.png)



---



## Lab Components



### VMware Workstation Pro



VMware Workstation Pro hosts the virtual machines used in the lab. The environment uses a Bridged network to provide connectivity between the virtual machines and the local network.



![VMware Workstation](../Screenshots/12%20-%20Prerequisites/01_VMware_Workstation.png)



---



### Domain Controller (DC01)



The domain controller runs Windows Server 2022 and provides the following services:



- Active Directory Domain Services (AD DS)

- DNS Server

- Group Policy

- File Server

- Microsoft Entra Connect



The Active Directory domain used in this lab is **thousiflab.com**.



---



### Client Computer (WIN11-CLIENT01)



The client computer runs Windows 11 and is joined to the **thousiflab.com** domain. It is used to test domain sign-in and verify hybrid identity synchronization.



---



### Microsoft Entra ID



Microsoft Entra ID is connected to the on-premises Active Directory using Microsoft Entra Connect. User accounts, security groups, password hashes, and selected attributes are synchronized to the Microsoft Entra tenant.



Tenant:



- **thousiflab.onmicrosoft.com**



---



### Microsoft 365



Microsoft 365 uses identities synchronized to Microsoft Entra ID for user authentication and access to cloud services.



---



## Synchronization



Microsoft Entra Connect synchronizes the following objects from Active Directory to Microsoft Entra ID:



- Users

- Security Groups

- User Attributes

- Password Hashes



Synchronization is performed over a secure HTTPS connection (TCP 443).



---



## Summary



The lab combines an on-premises Active Directory environment with Microsoft Entra ID and Microsoft 365. Microsoft Entra Connect provides identity synchronization, allowing users to use the same account for both on-premises and cloud resources.

