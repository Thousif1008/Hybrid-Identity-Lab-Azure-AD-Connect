# Microsoft Entra ID



## Overview



Microsoft Entra ID is the cloud identity service used in this lab. It provides the cloud directory for Microsoft 365 and is used to synchronize identities from the on-premises Active Directory environment.



---



## Tenant Information



| Item | Value |
|------|-------|

| Tenant Name | `Thousiflab` |

| Primary Domain | `thousiflab.onmicrosoft.com` |

| License | Microsoft Entra ID Free |



The Microsoft Entra tenant was created as the cloud environment for this hybrid identity lab. It is used throughout the project to manage cloud identities and support directory synchronization.



![Microsoft Entra Admin Center](../Screenshots/03%20-%20Microsoft%20Entra%20ID/01_Entra_Admin_Center_Overview.png)



---



## Tenant Overview



The Microsoft Entra admin center is the primary portal for managing the cloud identity environment.



From this portal, administrators can:



- Manage users and groups

- Manage devices

- Configure enterprise applications

- Assign administrative roles

- Review tenant settings

- Verify synchronized objects after Microsoft Entra Connect is configured



---



## Domain Configuration



The tenant uses the default Microsoft domain:



`thousiflab.onmicrosoft.com`



No additional custom domains have been added. The default domain is used for administrator accounts and cloud identities throughout the lab.



The **Custom Domain Names** page is available to add and verify custom domains if required.



![Custom Domain Names](../Screenshots/03%20-%20Microsoft%20Entra%20ID/02_Custom_Domain_Names.png)



---



## Result



The Microsoft Entra tenant was successfully configured and is ready to synchronize users, groups, and password hashes from the on-premises Active Directory environment using Microsoft Entra Connect.

