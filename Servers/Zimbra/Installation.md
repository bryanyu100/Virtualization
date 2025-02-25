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
