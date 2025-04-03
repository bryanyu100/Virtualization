# Installation of Zimbra on Ubuntu 20.04
## 1. Prerequisites
- Ubuntu Server 20.04 ISO file
- 4 processors in total
- Minimum of 8 GB RAM
- Minimum of 50 GB Storage

## 2. Configure the server's IP address
Access the network configuration's directory in Ubuntu with the following command:
```
cd /etc/netplan
```

Open the network configuration file with an text editor, e.g. Vim
```
sudo vim 00-installer-config.yaml
```

After attributing a static IPv4 address to the server, save and quit the file, then apply your configuration with the following command:
```
sudo netplan apply
```

You can verify its modification with the following command:
```
ip a
```

Deactivate the system service `systemd-resolve`
```
sudo systemctl disable systemd-resolved
```

and stop it
```
sudo systemctl stop systemd-resolved
```

Remove the existing symbolic link to the `resolv.conf` file.
```
sudo unlink /etc/resolv.conf
```

Create a new file named `resolv.conf` and add the public DNS servers of your choice. In my case, I will use Google's DNS.
```
echo nameserver 8.8.8.8 | sudo tee /etc/resolv.conf
```

## 3. dnsmasq
Install the dnsmasq server to configure the DNS service in our Zimbra server
```
sudo apt install dnsmasq -y
```

Open the `/etc/dnsmasq.conf` file and make the minimum configurations in it.
```
sudo vim /etc/dnsmasq.conf
```

- port=53 (5353 by default but change it to 53 and uncomment the line)
- bogus-priv (to be uncommented)
- strict-order (to be uncommented)
- listen-address=127.0.0.1 (to be uncommented)
- expand-hosts (to be uncommented)
- domain=[_domain_name_] (uncomment the line and change _domain_name_ to the domain name of your organization)

Save and quit the file
```
:wq
```

Restart the dnsmasq service with the following command
```
sudo systemctl restart dnsmasq
```

Create a backup of the `/etc/dnsmasq.conf` file
```
sudo mv /etc/dnsmasq.conf /etc/dnsmasq.conf.bak
```

Then reopen the original file to reedit it
```
sudo vim /etc/dnsmasq.conf
```

The lines you will have to add are the following:
- server=8.8.8.8
- listen-address=127.0.0.1
- domain=[_your_zimbra_server_A_record_]
- mx-host=[_your_zimbra_server_mx_record_]
- address=/[_your_zimbra_server_A_record_]/[_your_zimbra_server_IP_]

After backing up this file, change the hostname for this server and run the command in bash.
```
sudo hostnamectl set-hostname [your_zimbra_server_A_record]
exec bash
```

Open the `/etc/hosts` file
```
sudo vim /etc/hosts
```

In this file, you will need to insert a DNS record for your Zimbra server.
[zimbra_server_ip]          [zimbra_server_dns_record]

*Replace those variables with the values you have for both of them.

After that, you can save and exit the file to start downloading and installing Zimbra.

## 4. Download Zimbra
Access the /tmp folder and download the Zimbra installation file.
```
cd /tmp
```

```
wget https://files.zimbra.com/downloads/8.8.15_GA/zcs-8.8.15_GA_4179.UBUNTU20_64.20211118033954.tgz
```

Make an archive of the Zimbra download.
```
tar xvf zcs-8.8.15_GA_*.tgz
```

## 5. Install Zimbra
Navigate to the `zcs*/` directory and install Zimbra as super-user `root` with the `install.sh` instalation script.
```
cd zcs*/
```

There are two ways to run the installation script.

1. Connect as root to launch the script.

```
sudo su
```

```
./install.sh
```

2. Launch the script with sudo.
```
sudo ./install.sh
```

Accept the license terms by entering `Y`.

Track the packages to be accepted.

**ATTENTION !** There are some that you will refuse. For packages that you don't install, simply press and enter `N` for No and press `Enter` for the ones you're going to install.

The packages to be refused are as follows:
- zimbra-dnscache
- zimbra-imapd

Accept the system modification of your Zimbra server

- Press `Y` for Yes
- Press `Enter`

Don't change the domain name

- Press `N` for No
- Press `Enter`

Change the password for the Zimbra administrator account.

- Press and enter `6` to access the `zimbra-store` menu.
- Press and enter `4` to configure the Zimbra admin account's password

Return to the main menu and apply the configuration.
- Press and enter `r` to return to the main menu
- Press and enter `a` to apply the configuration

Press and enter the `Enter` key on your keyboard two times, then enter `Yes` and enter the `Enter` key one more time.

After the installation is complete, you can check the status of your Zimbra server with the following command:
```
sudo su - zimbra -c "zmcontrol status"
```

There you have it. Your installation of Zimbra on an Ubuntu Server 20.04 instance is done !

Time to access its interface web to proceed with configurations.
