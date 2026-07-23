# Password Hash Synchronization



## Overview



To verify Password Hash Synchronization, the password of an existing Active Directory user was changed. After running a delta synchronization, the user signed in to Microsoft Entra ID using the new password.



---



## Resetting the Password



The password for the user **Kabir Ahmed** was reset in Active Directory.



![Password Reset in Active Directory](../04%20-%20Screenshots/10%20-%20Password%20Hash%20Synchronization/01_Reset_Password_in_Active_Directory.png)



---



## Running a Delta Synchronization



After changing the password, a manual delta synchronization was started to send the updated password hash to Microsoft Entra ID.



```powershell

Start-ADSyncSyncCycle -PolicyType Delta

```



The command completed successfully.



![Delta Synchronization](../04%20-%20Screenshots/10%20-%20Password%20Hash%20Synchronization/02_Delta_Synchronization_Success.png)



---



## Testing the Password



After the synchronization completed, the user signed in to the Microsoft account portal using the new password.



The successful sign-in confirmed that the password change in Active Directory had been synchronized to Microsoft Entra ID.



![Successful Sign-In](../04%20-%20Screenshots/10%20-%20Password%20Hash%20Synchronization/03_Successful_Sign_In_After_Password_Reset.png)



---



## Result



The password change was synchronized successfully from Active Directory to Microsoft Entra ID. After the delta synchronization, the user was able to sign in using the new password, confirming that Password Hash Synchronization was working correctly.

