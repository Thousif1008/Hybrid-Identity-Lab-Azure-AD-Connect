\# Synchronization Health



\## Overview



Synchronization health was verified by checking the synchronization scheduler, reviewing a Microsoft Entra health alert, confirming that the synchronization service was running, and performing a manual synchronization.



\---



\## Synchronization Scheduler



The synchronization scheduler was checked using PowerShell to verify that automatic synchronization was enabled and operating normally.



```powershell

Get-ADSyncScheduler

```



The output shows the synchronization interval, scheduler status, and the next scheduled synchronization cycle.



!\[Synchronization Scheduler](../04%20-%20Screenshots/08%20-%20Synchronization%20Health/04\_ADSync\_Scheduler\_Status.png)



\---



\## Microsoft Entra Health Alert



A Microsoft Entra health alert was received indicating that the Password Hash Synchronization heartbeat had been skipped.



The alert included information about the detected issue and recommended checking the synchronization service.



!\[Microsoft Entra Health Alert](../04%20-%20Screenshots/08%20-%20Synchronization%20Health/01\_Entra\_Health\_Alert.png)



\---



\## Recommended Action



The alert recommended verifying the Microsoft Entra Sync service and restarting it if necessary.



!\[Recommended Action](../04%20-%20Screenshots/08%20-%20Synchronization%20Health/02\_Recommended\_Action.png)



\---



\## Service Verification



The \*\*Microsoft Azure AD Sync\*\* service was checked on the server and confirmed to be running.



!\[Microsoft Azure AD Sync Service](../04%20-%20Screenshots/08%20-%20Synchronization%20Health/03\_Azure\_AD\_Sync\_Service\_Running.png)



\---



\## Manual Synchronization



A manual delta synchronization was performed to verify that synchronization was working correctly.



```powershell

Start-ADSyncSyncCycle -PolicyType Delta

```



The command completed successfully.



!\[Manual Delta Synchronization](../04%20-%20Screenshots/08%20-%20Synchronization%20Health/05\_Manual\_Delta\_Synchronization.png)



\---



\## Result



Although a Microsoft Entra health alert was received, the synchronization scheduler was enabled, the Microsoft Azure AD Sync service was running, and a manual delta synchronization completed successfully. These checks confirmed that synchronization between Active Directory and Microsoft Entra ID was operating correctly.

