# Microsoft Entra Connect



## Overview



Microsoft Entra Connect is used to synchronize identities between the on-premises Active Directory environment and Microsoft Entra ID. In this lab, Password Hash Synchronization (PHS) was configured so users can use their on-premises Active Directory credentials to sign in to Microsoft 365 services.



---



## Download



The Microsoft Entra Connect installer was downloaded from the Microsoft Entra admin center and installed on the domain controller.



![Download Microsoft Entra Connect](../04%20-%20Screenshots/04%20-%20Entra%20Connect/01_Download_Entra_Connect.png)



---



## Installation



The installer was launched on the domain controller. After accepting the license agreement, the installation continued using **Express Settings**.



Express Settings configures:



- Password Hash Synchronization

- Required Microsoft Entra Connect components

- Automatic synchronization



![License Agreement](../04%20-%20Screenshots/04%20-%20Entra%20Connect/02_License_Agreement.png)



---



## Connect to Microsoft Entra ID



The Microsoft Entra Global Administrator account was used to connect Microsoft Entra Connect to the Microsoft Entra tenant.



| Item | Value |

|------|-------|

| Administrator Account | `Thousif@thousiflab.onmicrosoft.com` |



![Connect to Microsoft Entra ID](../04%20-%20Screenshots/04%20-%20Entra%20Connect/03_User_Sign_In.png)



---



## Connect to Active Directory



The Enterprise Administrator account for the on-premises Active Directory domain was used to configure synchronization.



| Item | Value |

|------|-------|

| Domain | `thousiflab.com` |

| Account | `THOUSIFLABAdministrator` |



![Connect to Active Directory](../04%20-%20Screenshots/04%20-%20Entra%20Connect/04_Connect_To_AD.png)



---



## Configuration



Before installation, Microsoft Entra Connect displayed the configuration that would be applied.



The selected configuration included:



- Install the synchronization engine

- Configure the Microsoft Entra ID connector

- Configure the `thousiflab.com` connector

- Enable Password Hash Synchronization

- Enable automatic upgrade

- Start the synchronization process after installation



![Ready to Configure](../04%20-%20Screenshots/04%20-%20Entra%20Connect/05_Ready_To_Configure.png)



---



## Installation Complete



After the installation finished, Microsoft Entra Connect successfully completed the configuration and started the initial synchronization process.



The installation also confirmed that:



- The synchronization service was configured successfully.

- The initial synchronization process started automatically.

- `ms-DS-ConsistencyGuid` is used as the source anchor attribute.



![Configuration Complete](../04%20-%20Screenshots/04%20-%20Entra%20Connect/06_Configuration_Complete.png)



---



## Result



Microsoft Entra Connect was successfully installed and configured. The on-premises Active Directory environment is now connected to Microsoft Entra ID, allowing users, groups, and password hashes to be synchronized automatically.

