# Install Prometheus in Ubuntu 20.04

## 1. Prerequisites
- Ubuntu Server 20.04 ISO file

## 2. Preparation
Update all packages of your Prometheus server
```
sudo apt update && sudo apt upgrade -y
```

Install nginx.
```
sudo apt install nginx -y
```

Create a group for a newly created `user` called prometheus in your Prometheus server.
```
sudo groupadd prometheus
```

Check its creation by executing the following command:
```
cat /etc/group
```

Now create the `prometheus` user.
```
sudo useradd -s /sbin/nologin --system -g prometheus prometheus
```

Check its existance by executing the following command:
```
cat /etc/passwd
```

Create a repertory named `prometheus`.
```
sudo mkdir /var/lib/Prometheus
for i in rules rules.d files_sd; do sudo mkdir -p /etc/prometheus/${i}; done
```

## 3. Installation of Prometheus
Install curl
```
sudo apt install curl -y
```

