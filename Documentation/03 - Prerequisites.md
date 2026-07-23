# Prerequisites



The following hardware, software, and services were used to build this hybrid identity lab.



---



## Lab Environment



The lab consists of one Windows Server 2022 domain controller and one Windows 11 Pro client running in VMware Workstation Pro.



![VMware Workstation](../Screenshots/12%20-%20Prerequisites/01_VMware_Workstation.png)



---



## Hardware



- 64-bit processor with virtualization support (Intel VT-x or AMD-V)

- Minimum 4 CPU cores (6 or more recommended)

- 16 GB RAM minimum (32 GB recommended)

- At least 100 GB of available storage



---



## Virtualization Software



- VMware Workstation Pro



---



## Operating Systems



### Windows Server 2022



The domain controller was deployed on Windows Server 2022.



![Windows Server 2022](../Screenshots/12%20-%20Prerequisites/02_Windows_Server_2022.png)



### Windows 11 Pro



The client machine was deployed on Windows 11 Pro.



![Windows 11 Pro](../Screenshots/12%20-%20Prerequisites/03_Windows_11_Pro.png)



---



## Windows Server Roles



The following roles and features were configured:



- Active Directory Domain Services (AD DS)

- DNS Server

- Group Policy



---



## Microsoft Services



- Microsoft 365 Trial Tenant

- Microsoft Entra ID

- Microsoft Entra Connect



---



## Networking



- Static IP address for the domain controller

- Internet connection

- VMware virtual networking



---



## PowerShell



PowerShell was used to manage and verify synchronization.



```powershell

Start-ADSyncSyncCycle -PolicyType Initial

Start-ADSyncSyncCycle -PolicyType Delta

Get-ADSyncScheduler

```



---



## Lab Environment Summary



| Component | Details |

|----------|---------|

| Hypervisor | VMware Workstation Pro |

| Domain Controller | Windows Server 2022 |

| Client Machine | Windows 11 Pro |

| Domain | thousiflab.com |

| Microsoft Entra Tenant | thousiflab.onmicrosoft.com |

| Synchronization Method | Password Hash Synchronization |

