# Synchronization



## Overview



Synchronization copies identities from the on-premises Active Directory environment to Microsoft Entra ID. After Entra Connect was configured, the initial synchronization imported existing users into the Microsoft Entra tenant. A new user was then created in Active Directory to verify that new changes could also be synchronized successfully.



---



## Initial Synchronization



After Entra Connect was configured, the initial synchronization completed successfully. Existing Active Directory users were synchronized to Microsoft Entra ID and appeared in the Microsoft Entra admin center.



The **On-premises sync** status confirms that these accounts are synchronized from the local Active Directory environment.



![Users After Initial Synchronization](../Screenshots/05%20-%20Synchronization/01_Entra_Users_After_Initial_Sync.png)



---



## Creating a Test User



To verify that new changes would synchronize correctly, a new user named **Hybrid Test** was created in the **IT** organizational unit in Active Directory.



![New Active Directory User](../Screenshots/05%20-%20Synchronization/02_New_AD_User_Created.png)



---



## Running a Delta Synchronization



After creating the new user, a manual delta synchronization was started from PowerShell to synchronize only the recent changes.



```powershell

Start-ADSyncSyncCycle -PolicyType Delta

```



The command completed successfully.



![Delta Synchronization](../Screenshots/05%20-%20Synchronization/03_Delta_Sync_PowerShell.png)



---



## Verifying the New User



After the delta synchronization completed, the **Hybrid Test** account appeared in Microsoft Entra ID.



This confirmed that the newly created Active Directory user was synchronized successfully.



![Hybrid Test User](../Screenshots/05%20-%20Synchronization/04_New_User_In_Entra.png)



---



## User Details



The Microsoft Entra user profile confirms that the **Hybrid Test** account is available in the cloud directory after synchronization.



![Hybrid Test User Overview](../Screenshots/05%20-%20Synchronization/05_New_User_Overview.png)



---



## Result



The initial synchronization successfully imported existing Active Directory users into Microsoft Entra ID. A new user created in the on-premises Active Directory environment was synchronized successfully using a manual delta synchronization, confirming that identity synchronization was working correctly.

