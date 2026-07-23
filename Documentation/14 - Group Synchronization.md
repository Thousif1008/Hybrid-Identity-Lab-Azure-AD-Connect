\# Group Synchronization



\## Overview



This section verifies that security groups created in the on-premises Active Directory environment are synchronized to Microsoft Entra ID. To test this, a new security group was created in Active Directory, synchronized using a delta synchronization, and verified in Microsoft Entra ID.



\---



\## Creating a Security Group



A new security group named \*\*Cloud\_IT\_Admins\*\* was created in Active Directory.



!\[Security Group Created](../04%20-%20Screenshots/11%20-%20Group%20Synchronization/01\_AD\_Security\_Group\_Created.png)



\---



\## Running a Delta Synchronization



After creating the group, a manual delta synchronization was started.



```powershell

Start-ADSyncSyncCycle -PolicyType Delta

```



The command completed successfully.



!\[Delta Synchronization](../04%20-%20Screenshots/11%20-%20Group%20Synchronization/02\_Delta\_Synchronization\_Success.png)



\---



\## Verifying the Group



After the synchronization completed, the \*\*Cloud\_IT\_Admins\*\* group appeared in Microsoft Entra ID.



The group source is shown as \*\*Windows Server AD\*\*, indicating that the group was synchronized from Active Directory.



!\[Group in Microsoft Entra ID](../04%20-%20Screenshots/11%20-%20Group%20Synchronization/03\_Group\_Visible\_in\_Entra.png)



\---



\## Result



The \*\*Cloud\_IT\_Admins\*\* security group was synchronized successfully to Microsoft Entra ID. The synchronized group appeared with its source listed as \*\*Windows Server AD\*\*.

