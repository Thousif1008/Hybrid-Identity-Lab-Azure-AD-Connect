\# Active Directory



\## Overview



This section covers the on-premises Active Directory environment used in the hybrid identity lab. Windows Server 2022 was configured as the domain controller for the `thousiflab.com` domain. The server hosts Active Directory Domain Services (AD DS), DNS, and Group Policy.



An organizational structure was created to separate users, groups, computers, and resources before synchronizing the environment with Microsoft Entra ID.



\---



\## Domain Information



| Item | Value |

|------|-------|

| Domain | `thousiflab.com` |

| Domain Controller | `DC01` |

| Operating System | Windows Server 2022 |



\---



\## Organizational Unit Structure



An \*\*Enterprise\*\* organizational unit was created to organize Active Directory objects. Separate organizational units were added for users, groups, computers, and resources to keep the directory organized and easier to manage.



!\[Enterprise OU Structure](../04%20-%20Screenshots/02%20-%20Active%20Directory/01\_Enterprise\_OU\_Structure.png)



\---



\## User Organization



Under the \*\*Users\*\* organizational unit, additional folders were created to separate accounts by department and function.



The following organizational units were created:



\- Admins

\- Disabled Users

\- Finance

\- HR

\- IT

\- Management

\- Sales

\- Service Accounts



This structure allows users to be managed independently and makes it easier to apply Group Policy and permissions.



!\[Department OUs](../04%20-%20Screenshots/02%20-%20Active%20Directory/02\_Department\_OUs.png)



\---



\## User Accounts



User accounts were created and placed in their respective organizational units. Departmental accounts are separated based on their role, making administration and policy management simpler.



The lab also includes a test account that is used later to verify directory synchronization with Microsoft Entra ID.



!\[Department Users](../04%20-%20Screenshots/02%20-%20Active%20Directory/03\_Department\_Users.png)



\---



\## Group Policy



Group Policy Management is configured for the domain to manage security and administrative settings.



The environment includes the default Group Policy Objects along with additional policies created for organizational units as required by the lab.



!\[Group Policy Management](../04%20-%20Screenshots/02%20-%20Active%20Directory/04\_Group\_Policy\_Management.png)



\---



\## DNS Configuration



DNS is hosted on the domain controller and is integrated with Active Directory.



The forward lookup zone contains records for the domain controller, client computer, and Active Directory service records used for name resolution within the domain.



Configured records include:



\- DC01

\- WIN11-CLIENT01

\- Active Directory service records



!\[DNS Manager](../04%20-%20Screenshots/02%20-%20Active%20Directory/05\_DNS\_Manager.png)



\---



\## Result



The Active Directory environment was successfully configured with:



\- A Windows Server 2022 domain controller

\- The `thousiflab.com` domain

\- A structured organizational unit hierarchy

\- Departmental user accounts

\- Group Policy

\- Integrated DNS



The environment is ready for synchronization with Microsoft Entra ID using Microsoft Entra Connect.

