\# Attribute Synchronization



\## Overview



This section verifies that changes made to user attributes in the on-premises Active Directory environment are synchronized to Microsoft Entra ID. To test this, the business phone number of an existing user was updated in Active Directory and verified after synchronization.



\---



\## Updating the User Attribute



The \*\*Business phone number\*\* for the user \*\*Ethan Smith\*\* was updated in Active Directory.



!\[User Attribute Updated in Active Directory](../04%20-%20Screenshots/09%20-%20Attribute%20Synchronization/01\_AD\_User\_Attribute\_Updated.png)



\---



\## Running a Delta Synchronization



A manual delta synchronization was started to synchronize the updated user attribute.



```powershell

Start-ADSyncSyncCycle -PolicyType Delta

```



The command completed successfully.



!\[Delta Synchronization](../04%20-%20Screenshots/09%20-%20Attribute%20Synchronization/02\_Delta\_Synchronization\_Success.png)



\---



\## Verifying the Updated Attribute



After the synchronization completed, the updated \*\*Business phone\*\* number for \*\*Ethan Smith\*\* appeared in Microsoft Entra ID.



This confirms that changes made to user attributes in Active Directory are synchronized successfully to Microsoft Entra ID.



!\[Updated User Attribute in Microsoft Entra ID](../04%20-%20Screenshots/09%20-%20Attribute%20Synchronization/03\_Entra\_User\_Attribute\_Verified.png)



\---



\## Result



The updated business phone number for the user \*\*Ethan Smith\*\* was synchronized successfully from Active Directory to Microsoft Entra ID. This confirms that changes to user attributes are replicated correctly through Entra Connect.

