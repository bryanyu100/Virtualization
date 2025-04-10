# Author : Bryan Yu
# Installation of Active Directory in Windows Server 2019

## 1. Prerequisites
- Minimum of 60 GB Storage
- Windows Server 2019 ISO file
- Static IPv4 address
- Name change for server

## 2. Installation of Active Directory roles
In the Server Manager, click the `Add Roles and Features` option.

![](https://github.com/bryanyu100/Virtualization/blob/main/Active%20Directory/Images/2025-04-03%20152404.png)

Click `Next`.

![](https://github.com/bryanyu100/Virtualization/blob/main/Active%20Directory/Images/2025-04-03%20153020.png)

Make sure that the `Role-based or feature-based installation` option is selected. Then click `Next`.

![](https://github.com/bryanyu100/Virtualization/blob/main/Active%20Directory/Images/2025-04-03%20153429.png)

Make sure that your Windows server is selected in the list. Then click `Next`.

![](https://github.com/bryanyu100/Virtualization/blob/main/Active%20Directory/Images/2025-04-03%20153649.png)

Check `Active Directory Domain Services` in the list of roles. Then click Next.

![](https://github.com/bryanyu100/Virtualization/blob/main/Active%20Directory/Images/2025-04-03%20153751.png)

In the `Add Roles and Features Wizard` popup dialog, make sure that `Include management tools (if applicable)` is checked and then click the `Add Features` option.

![](https://github.com/bryanyu100/Virtualization/blob/main/Active%20Directory/Images/2025-04-03%20153929.png)

Check `DHCP Server` and `DNS Server` in the list of roles. Then click `Next`.

![](https://github.com/bryanyu100/Virtualization/blob/main/Active%20Directory/Images/2025-04-03%20154010.png)

Click `Next`.

![](https://github.com/bryanyu100/Virtualization/blob/main/Active%20Directory/Images/2025-04-03%20154128.png)

Click `Next`.

![](https://github.com/bryanyu100/Virtualization/blob/main/Active%20Directory/Images/2025-04-03%20154220.png)

Click `Next`.

![](https://github.com/bryanyu100/Virtualization/blob/main/Active%20Directory/Images/2025-04-03%20154255.png)

Click `Next`.

![](https://github.com/bryanyu100/Virtualization/blob/main/Active%20Directory/Images/2025-04-03%20154442.png)

Click `Install`.

![](https://github.com/bryanyu100/Virtualization/blob/main/Active%20Directory/Images/2025-04-03%20154508.png)

Once the installation is completed, click `Close`.

![](https://github.com/bryanyu100/Virtualization/blob/main/Active%20Directory/Images/2025-04-08%20143430.png)

## 3. Post-installation configuration
In the Server Manager, click on the flag with a warning icon. Then click the option `Promote this server to domain controller`.

![](https://github.com/bryanyu100/Virtualization/blob/main/Active%20Directory/Images/2025-04-08%20143529.png)

![](https://github.com/bryanyu100/Virtualization/blob/main/Active%20Directory/Images/2025-04-08%20143614.png)

Check the option `Add a new forest` and give a domain name. Click `Next`.

![](https://github.com/bryanyu100/Virtualization/blob/main/Active%20Directory/Images/2025-04-08%20143635.png)

Enter and confirm a password for the administrator account. Click `Next`.

![](https://github.com/bryanyu100/Virtualization/blob/main/Active%20Directory/Images/2025-04-08%20143705.png)

Click `Next`.

![](https://github.com/bryanyu100/Virtualization/blob/main/Active%20Directory/Images/2025-04-08%20143754.png)

Click `Next`.

![](https://github.com/bryanyu100/Virtualization/blob/main/Active%20Directory/Images/2025-04-08%20143810.png)

Click `Next`.

![](https://github.com/bryanyu100/Virtualization/blob/main/Active%20Directory/Images/2025-04-08%20143849.png)

Click `Next`.

![](https://github.com/bryanyu100/Virtualization/blob/main/Active%20Directory/Images/2025-04-08%20143910.png)

If all the verifications of the required configuration are good, click `Install`.

![](https://github.com/bryanyu100/Virtualization/blob/main/Active%20Directory/Images/2025-04-08%20143952.png)

Once the installation is completed, you should see a message on the top that says that your AD server is now correctly configured as a domain controller. Click `Close`.

![](https://github.com/bryanyu100/Virtualization/blob/main/Active%20Directory/Images/2025-04-08%20144112.png)

Back in the Server Manager once again, click on the flag with a warning icon to finalize the DHCP configuration by clicking the option `Finish the DHCP configuration`.

![](https://github.com/bryanyu100/Virtualization/blob/main/Active%20Directory/Images/2025-04-08%20144147.png)

Click `Next`.

![](https://github.com/bryanyu100/Virtualization/blob/main/Active%20Directory/Images/2025-04-08%20144255.png)

On the Authorization screen, check the first option and make sure to put the right information as shown in my screenshot example. (DOMAIN\Administrator)

Click `Validate`.

![](https://github.com/bryanyu100/Virtualization/blob/main/Active%20Directory/Images/2025-04-08%20144351.png)

Once the validation is done, click `Close`.

![](https://github.com/bryanyu100/Virtualization/blob/main/Active%20Directory/Images/2025-04-08%20144422.png)

There you have it, your Active Directory server is installed and configured as a domain controller !

In this tutorial, the DHCP and DNS servers were also installed.

![](https://github.com/bryanyu100/Virtualization/blob/main/Active%20Directory/Images/2025-04-08%20144456.png)
