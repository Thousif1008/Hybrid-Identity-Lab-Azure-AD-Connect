# Hybrid Identity Testing



## Overview



This section verifies that changes made in the on-premises Active Directory environment are synchronized to Microsoft Entra ID. To test this, an existing user account was disabled in Active Directory and the change was synchronized using a manual delta synchronization.



---



## Selecting the User



An existing Active Directory user named **James Brown** was selected for testing.



![User Selected in Active Directory](../04%20-%20Screenshots/06%20-%20Hybrid%20Identity%20Testing/01_User_Selected_In_AD.png)



---



## Disabling the User Account



The user account was disabled in Active Directory.



![User Disabled Confirmation](../04%20-%20Screenshots/06%20-%20Hybrid%20Identity%20Testing/02_User_Disabled_Confirmation.png)



---



## Running a Delta Synchronization



A manual delta synchronization was started to synchronize the account status change to Microsoft Entra ID.



```powershell

Start-ADSyncSyncCycle -PolicyType Delta

```



The command completed successfully.



![Delta Synchronization](../04%20-%20Screenshots/06%20-%20Hybrid%20Identity%20Testing/03_Delta_Sync_PowerShell(1).png)



---



## Verifying the Result



After the synchronization completed, the **James Brown** account in Microsoft Entra ID showed the account status as **Disabled**, confirming that the change made in Active Directory was synchronized successfully.



![Disabled Account in Microsoft Entra ID](../04%20-%20Screenshots/06%20-%20Hybrid%20Identity%20Testing/04_Account_Status_Disabled_In_Entra.png)



---



## Result



The test confirmed that changes made to user accounts in the on-premises Active Directory environment are synchronized to Microsoft Entra ID. Disabling a user in Active Directory updated the account status in Microsoft Entra ID after running a delta synchronization.

