\# Microsoft 365 Tenant



\## Overview



This lab uses a Microsoft 365 tenant as the cloud environment for Microsoft Entra ID and Microsoft 365 services. The tenant is used throughout the project to synchronize on-premises Active Directory objects, verify cloud identities, and test hybrid identity scenarios using Microsoft Entra Connect.



\## Purpose



The Microsoft 365 tenant provides the cloud directory required for this hybrid identity lab. It is later connected to the on-premises Active Directory domain to synchronize users, groups, and password hashes.



\## Tenant Details



| Item | Value |

|------|-------|

| Tenant Domain | `thousiflab.onmicrosoft.com` |

| Administrator Account | `Thousif@thousiflab.onmicrosoft.com` |



\## Setup



A Microsoft account was used to provision a Microsoft 365 tenant. During the setup process, the tenant domain `thousiflab.onmicrosoft.com` was created along with the administrator account `Thousif@thousiflab.onmicrosoft.com`.



After the tenant was created, the Microsoft 365 Admin Center became available for managing users, subscriptions, and cloud services that would be used later in the lab.



\## Microsoft 365 Admin Center



The Microsoft 365 Admin Center serves as the central management portal for the tenant. Throughout this project it is used to:



\- Manage Microsoft 365 services.

\- Access Microsoft Entra ID.

\- Verify synchronized users.

\- Test Microsoft 365 sign-in after synchronization.

\- Manage licenses and cloud identities.



!\[Microsoft 365 Admin Center](../Screenshots/01%20-%20Microsoft%20365%20Tenant/01\_Microsoft365\_Admin\_Center\_Home.png)



\## Result



The Microsoft 365 tenant was successfully created and configured. The cloud environment is now ready to be connected with the on-premises Active Directory environment using Microsoft Entra Connect.

