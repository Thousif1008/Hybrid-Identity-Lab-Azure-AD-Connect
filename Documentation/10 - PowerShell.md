\# PowerShell



\## Overview



PowerShell was used to view the synchronization scheduler and manually start synchronization between the on-premises Active Directory environment and Microsoft Entra ID.



\---



\## Synchronization Scheduler



The following command was used to view the current synchronization scheduler configuration.



```powershell

Get-ADSyncScheduler

```



The output shows information such as:



\- Synchronization interval

\- Next synchronization cycle

\- Scheduler status

\- Synchronization status



This command can be used to verify that the synchronization scheduler is enabled and running.



!\[Synchronization Scheduler](../04%20-%20Screenshots/07%20-%20PowerShell/01\_Get\_ADSyncScheduler.png)



\---



\## Delta Synchronization



A delta synchronization synchronizes only the changes made since the last synchronization. This is useful after creating, modifying, or disabling users in Active Directory.



```powershell

Start-ADSyncSyncCycle -PolicyType Delta

```



The command completed successfully.



!\[Delta Synchronization](../04%20-%20Screenshots/07%20-%20PowerShell/02\_Start\_Delta\_Sync.png)



\---



\## Initial Synchronization



An initial synchronization performs a full synchronization of the Active Directory environment with Microsoft Entra ID. This is typically used during the first synchronization or when a complete synchronization is required.



```powershell

Start-ADSyncSyncCycle -PolicyType Initial

```



The command completed successfully.



!\[Initial Synchronization](../04%20-%20Screenshots/07%20-%20PowerShell/03\_Start\_Initial\_Sync.png)



\---



\## Result



PowerShell was used to monitor the synchronization scheduler and manually start both delta and initial synchronization cycles. These commands provide a quick way to synchronize changes between Active Directory and Microsoft Entra ID when needed.

