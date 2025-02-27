# Install Nextcloud in Ubuntu Server 22.04

## 1. Prerequisites
- Ubuntu Server 22.04 image

## 2. Installation of Nextcloud's prerequisites
Start by updating your system.
```
sudo apt update && sudo apt upgrade -y
```

Install Apache2
```
sudo apt install apache2 -y
```

Enable and start the Apache2 service
```
sudo systemctl enable apache2 && sudo systemctl start apache2
```

Install the PHP packages
```
sudo apt-get install php8.1 php8.1-cli php8.1-common php8.1-imap php8.1-redis php8.1-snmp php8.1-xml php8.1-zip php8.1-mbstring php8.1-curl php8.1-gd php8.1-mysql -y
```

Install the MariaDB server
```
sudo apt install mariadb-server -y
```

Enable and start the MariaDB service
```
sudo systemctl enable mariadb && sudo systemctl start mariadb
```

Enter the MySQL client
```
sudo mysql
```

Create a database named `nextcloud`
```
CREATE DATABASE nextcloud;
```

Grant all privileges on the database named `nextcloud` to a SQL user named `nextcloud` with a specified password. Replace the variable [password] with a password of your choice.
```
GRANT ALL PRIVILEGES ON nextcloud.* TO 'nextcloud'@'localhost' IDENTIFIED BY '[password]';
```

Reload the granted privileges
```
FLUSH PRIVILEGES
```

Exit the MySQL client
```
exit;
```

