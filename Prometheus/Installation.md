# Author : Bryan Yu
# Install Prometheus in Ubuntu 20.04

## 1. Prerequisites
- Ubuntu Server 20.04 ISO file

## 2. Preparation
Update all packages of your Prometheus server
```
sudo apt update && sudo apt upgrade -y
```

![](https://github.com/bryanyu100/Virtualization/blob/main/Prometheus/Assets/Capture%20d%E2%80%99%C3%A9cran%202025-05-20%20135359.png)

Install nginx.
```
sudo apt install nginx -y
```

![](https://github.com/bryanyu100/Virtualization/blob/main/Prometheus/Assets/Capture%20d%E2%80%99%C3%A9cran%202025-05-20%20135444.png)

Create a group for a newly created `user` called prometheus in your Prometheus server.
```
sudo groupadd prometheus
```

![](https://github.com/bryanyu100/Virtualization/blob/main/Prometheus/Assets/Capture%20d%E2%80%99%C3%A9cran%202025-05-20%20135533.png)

Check its creation by executing the following command:
```
cat /etc/group
```

![](https://github.com/bryanyu100/Virtualization/blob/main/Prometheus/Assets/Capture%20d%E2%80%99%C3%A9cran%202025-05-20%20135612.png)

Now create the `prometheus` user.
```
sudo useradd -s /sbin/nologin --system -g prometheus prometheus
```

![](https://github.com/bryanyu100/Virtualization/blob/main/Prometheus/Assets/Capture%20d%E2%80%99%C3%A9cran%202025-05-20%20135712.png)

Check its existance by executing the following command:
```
cat /etc/passwd
```

![](https://github.com/bryanyu100/Virtualization/blob/main/Prometheus/Assets/Capture%20d%E2%80%99%C3%A9cran%202025-05-20%20135844.png)

Create a repertory named `prometheus`.
```
sudo mkdir /var/lib/Prometheus
for i in rules rules.d files_sd; do sudo mkdir -p /etc/prometheus/${i}; done
```

![](https://github.com/bryanyu100/Virtualization/blob/main/Prometheus/Assets/Capture%20d%E2%80%99%C3%A9cran%202025-05-20%20135924.png)

## 3. Installation of Prometheus
Install curl
```
sudo apt install curl -y
```

![](https://github.com/bryanyu100/Virtualization/blob/main/Prometheus/Assets/Capture%20d%E2%80%99%C3%A9cran%202025-05-20%20140046.png)

Download the latest version of Prometheus with the `wget` command.
```
mkdir -p /tmp/prometheus
cd /tmp/prometheus
curl -s https://api.github.com/repos/prometheus/prometheus/releases/latest | grep browser_download_url | grep linux-amd64 | cut -d '"' -f 4 | wget -qi –
```

![](https://github.com/bryanyu100/Virtualization/blob/main/Prometheus/Assets/Capture%20d%E2%80%99%C3%A9cran%202025-05-20%20140129.png)

Extract the downloaded package file with the `tar` command.
```
tar xvf prometheus*.tar.gz
```

![](https://github.com/bryanyu100/Virtualization/blob/main/Prometheus/Assets/Capture%20d%E2%80%99%C3%A9cran%202025-05-20%20140221.png)

Access the directory created as a result of the archive decompression.

*Check your folder for the downloaded and unzipped version of Prometheus.
```
ls
```

```
cd /tmp/prometheus/prometheus-2.47.2.linux-amd64
```

Move the Prometheus and Promtool files from the Prometheus folder to `/usr/local/bin`.
```
sudo mv prometheus promtool /usr/local/bin/
```

![](https://github.com/bryanyu100/Virtualization/blob/main/Prometheus/Assets/Capture%20d%E2%80%99%C3%A9cran%202025-05-20%20140248.png)

## 4. Configuration of Prometheus
Create a configuration file named `prometheus.yml` in this `/etc/prometheus` directory.
```
sudo mv prometheus.yml /etc/prometheus/prometheus.yml
```

```
sudo mv consoles/ console_libraries/ /etc/prometheus/
```

```
sudo nano /etc/prometheus/prometheus.yml
```

![](https://github.com/bryanyu100/Virtualization/blob/main/Prometheus/Assets/Capture%20d%E2%80%99%C3%A9cran%202025-05-20%20140402.png)

View the contents of this last file.

![](https://github.com/bryanyu100/Virtualization/blob/main/Prometheus/Assets/Capture%20d%E2%80%99%C3%A9cran%202025-05-20%20140430.png)

### 4.1. Creation of the `Prometheus Systemd` service
Create a file for Prometheus' systemd service.
```
sudo nano /etc/systemd/system/prometheus.service
```

![](https://github.com/bryanyu100/Virtualization/blob/main/Prometheus/Assets/Capture%20d%E2%80%99%C3%A9cran%202025-05-20%20140610.png)

Insert the following content.
```
[Unit]
Description=Prometheus
Documentation=https://prometheus.io/docs/introduction/overview/
Wants=network-online.target
After=network-online.target

[Service]
Type=simple
User=prometheus
Group=prometheus
ExecReload=/bin/kill -HUP \$MAINPID
ExecStart=/usr/local/bin/prometheus \
--config.file=/etc/prometheus/prometheus.yml \
--storage.tsdb.path=/var/lib/prometheus \
--web.console.templates=/etc/prometheus/consoles \
--web.console.libraries=/etc/prometheus/console_libraries \
--web.listen-address=0.0.0.0:9090 \
--web.external-url=

SyslogIdentifier=prometheus
Restart=always

[Install]
WantedBy=multi-user.target
```

Change the ownership of these directories to the `prometheus` user and group previously created.
```
for i in rules rules.d files_sd; do sudo chown -R prometheus:prometheus /etc/prometheus/${i}; done
for i in rules rules.d files_sd; do sudo chmod -R 775 /etc/prometheus/${i}; done
sudo chown -R prometheus:prometheus /var/lib/prometheus/
```

![](https://github.com/bryanyu100/Virtualization/blob/main/Prometheus/Assets/Capture%20d%E2%80%99%C3%A9cran%202025-05-20%20140726.png)

Restart the `systemd` service.
```
sudo systemctl daemon-reload
```

Enable the `prometheus` service.
```
sudo systemctl enable prometheus
```

![](https://github.com/bryanyu100/Virtualization/blob/main/Prometheus/Assets/Capture%20d%E2%80%99%C3%A9cran%202025-05-20%20140815.png)

### 4.2. Firewall Configuration
Ensure your firewall is properly configured and allows traffic on ports `HTTPS (443)`, `HTTP (80)`, and `9090`. The Nginx web server presents itself as a ufw service.
```
sudo ufw allow in "Nginx Full"
```

```
sudo ufw allow 9090/tcp
```

![](https://github.com/bryanyu100/Virtualization/blob/main/Prometheus/Assets/Capture%20d%E2%80%99%C3%A9cran%202025-05-20%20140858.png)

## 5. Access to Prometheus' Web Interface
Start up the Prometheus service.
```
sudo systemctl start prometheus
```

Check its status to make sure it's `active (running)`.
```
sudo systemctl status prometheus
```

![](https://github.com/bryanyu100/Virtualization/blob/main/Prometheus/Assets/Capture%20d%E2%80%99%C3%A9cran%202025-05-20%20140922.png)

In a web browser of your choice, enter the URL address `http://[your_prometheus_server_ip]:9090`.

*Replace the `[your_prometheus_server_ip]` variable with the real value.

You should see the Prometheus dashboard tab.

![](https://github.com/bryanyu100/Virtualization/blob/main/Prometheus/Assets/Capture%20d%E2%80%99%C3%A9cran%202025-05-20%20141014.png)

# Reference
[Prometheus on Ubuntu Server 20.04](https://serverspace.io/support/help/install-prometheus-ubuntu-20-04/)
