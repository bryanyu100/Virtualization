# Install FreePBX on Linux

## 1. Prerequisites
- Linux OS (CentOS 7)
- Minimum of 8 GB Ram
- Minimum of 60 GB Storage
- FreePBX ISO

*You can download the FreePBX ISO file here : https://www.freepbx.org/downloads/

## 2. Installation of FreePBX in a Virtual Machine
After you launch your FreePBX server, press `Enter` to select the recommended installation of FreePBX.

Select the first option in the following window.

Proceed to the standard installation of FreePBX by pressing `Enter`.

Attribute a password to the `root` user. Then click `Done`.

Once the virtual machine configuration is completed, click on the `Reboot` button to restart the server.

After reboot, connect as `root` with its given password.

## 3. Network configuration
To configure the network of your FreePBX server, you'll have to edit the `/etc/sysconfig/network-scripts/ifcfg-eth0` network configuration file.

Edit the following lines:

- `BOOTPROTO=static`
- `IPADDR=[your_freepbx_server_ip]`

*Replace the [your_freepbx_server_ip] variable by the actual server IP of your FreePBX server.

Restart the network system with the `sudo service network restart` command. Then try pinging your server IP to test the validity of the network configuration.

## 4. Web interface setup
Use a PC client to access the web interface of your FreePBX server to complete the basic installation setup on the web.
