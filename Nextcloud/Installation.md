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

Go to the `/var/www/html` directory, and then download the compressed folder from Nextcloud.
```
cd /var/www/html
```

```
sudo wget https://download.nextcloud.com/server/releases/nextcloud-24.0.1.zip
```

Install the `unzip` command tool to extract files from compressed ZIP archives
```
sudo apt install unzip -y
```

Then decompress the compressed Nextcloud folder
```
sudo unzip nextcloud-24.0.1.zip
```

*The decompression can take a while. Please remain patient.

After the decompression is complete, change the ownership of a directory and its contents recursively. In this case, you change ownership of the `/var/www/html/nextcloud` directory and everything else which is located below in user and group `www-data`.

```
sudo chown -R www-data:www-data /var/www/html/nextcloud
```

Create and open a configuration file for the Nextcloud server
```
sudo touch /etc/apache2/sites-available/nextcloud.conf
```

```
sudo vim /etc/apache2/sites-available/nextcloud.conf
```

Insert the following content. *Replace the `[your_nextcloud_dns]` variable with the actual DNS of your Nextcloud server.
```
<VirtualHost * :80>
ServerName [your_nextcloud_dns]
DocumentRoot /var/www/html/nextcloud

<Directory /var/www/html/nextcloud/>
Require all granted
Options FollowSymlinks Multiviews
Allow Override All
<IfModule mod_dav.c>
Dav off
</IfModule>
</Directory>

ErrorLog /var/log/apache2/[your_nextcloud_dns].error_log
CustomLog /var/log/apache2/[your_nextcloud_dns].access_log common
</VirtualHost>
```

Save and exit the file
```
:wq
```

Enable the Apache virtual host configuration file named `nextcloud.conf`
```
sudo a2ensite nextcloud.conf
```

Enable the Apache module named `mod_rewrite`
```
sudo a2enmod rewrite
```

Restart the Apache web server
```
sudo systemctl restart apache2
```

Perform a syntax check on the Apache configuration file without restart the Apache service with this command:
```
sudo apache2 -t
```

If you get no syntax errors, it means your Nextcloud server is fully installed and configured. Now, you can access its web interface and do some advanced configurations.
