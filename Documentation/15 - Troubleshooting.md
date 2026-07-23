# Troubleshooting



## Windows 11 Home Edition



### Issue



The client virtual machine was initially installed with Windows 11 Home. This edition does not support joining an Active Directory domain.



### Resolution



The virtual machine was reinstalled with Windows 11 Pro, and the client was successfully joined to the domain.



---



## VMware Network Configuration



### Issue



The virtual machines could not access the internet after switching between NAT and Bridged networking.



### Resolution



The virtual network adapter was configured to use Bridged mode, and the IP settings were updated to match the local network. Internet connectivity was restored.



---



## Microsoft Edge WebView2 Runtime



### Issue



The Microsoft Entra Connect sign-in page did not load during the installation.



### Resolution



Microsoft Edge WebView2 Runtime was installed, and the installation was started again. The sign-in page loaded successfully.



---



## Microsoft Entra Licensing



### Issue



The default Microsoft Entra subscription did not include the features required to complete the hybrid identity lab.



### Resolution



A Microsoft trial subscription was activated to continue the Microsoft Entra Connect configuration and complete the synchronization tests.



---



## Password Hash Synchronization Health Alert



### Issue



A Microsoft Entra health notification reported that the Password Hash Synchronization heartbeat had not been received.



### Resolution



The Microsoft Entra Connect service was checked, and a manual synchronization was completed successfully. The environment continued to synchronize without any issues.

