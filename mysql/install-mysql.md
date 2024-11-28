# mysql tools

## MySQL 8 Password Reset

[Source](https://stackoverflow.com/a/65695683/520901)

1. update /etc/mysql/my.cnf and add lines:

```bash
 [mysqld]

 skip-grant-tables
```

2. restart mysql and clear the authentication_string for a specific user:

```bash
sudo systemctl restart mysql
sudo mysql
mysql> UPDATE mysql.user SET authentication_string=null WHERE User='root';
mysql> FLUSH PRIVILEGES;
mysql> exit;
```

3. update /etc/mysql/my.cnf and remove the line skip-grant-tables

4. restart mysql to get my.cnf changes:

```bash
sudo systemctl restart mysql
```

5. log in again and update the password (replace 'my password' with your password):

```bash
sudo mysql -u root
mysql> ALTER USER 'root'@'localhost' IDENTIFIED WITH caching_sha2_password BY 'my password';
mysql> FLUSH PRIVILEGES;
mysql> exit;
```

6. Finally, test

```bash
mysql -u root -p
```



## Installation

```bash
./openstack-create rtpdev mariadb-db1 mariadb
./openstack-create rtpdev mariadb-db2 mariadb
```

## Post-Installation (Both MariaDB instances)
./complete-mariadb-setup.sh

Running this script above will run the steps below. Make sure not to change `root` password.

```bash
sudo mysql_secure_installation
sudo systemctl status mariadb
```

Create a new admin account for all MariaDB administration tasks.

`sudo mysql`:

```sql
GRANT ALL ON *.* TO 'admin'@'localhost' IDENTIFIED BY 'password' WITH GRANT OPTION;
FLUSH PRIVILEGES;
exit;
```

## Add this to master /etc/mysql/my.cnf of mysql (Master)

`sudo vim /etc/mysql/my.cnf`:

```sql
[mysqld]
...
server-id = 1
#bind-address = 127.0.0.1
replicate-do-db = orca
...
```

```bash
{
sudo systemctl stop mariadb
sudo systemctl status mariadb
sudo systemctl start mariadb
sudo systemctl status mariadb
}
```

## Run these as 'admin' user on the mysql (Master)

Run `mysql -u admin -p` 

```sql
CREATE DATABASE orca;
GRANT ALL ON orca.* TO 'spinnaker'@'%' IDENTIFIED BY '0rcar0cks!';
USE orca;
CREATE TABLE IF NOT EXISTS tasks (
    task_id INT AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    PRIMARY KEY (task_id)
)  ENGINE=INNODB;
SHOW TABLES;
INSERT INTO tasks (title, description) VALUES ('task1', 'This is a description for task 1');
SELECT * FROM tasks;
GRANT REPLICATION SLAVE ON *.* TO 'replication_user'@'mariadb-db2.cisco.com' IDENTIFIED BY 'repl1cat10n';
FLUSH PRIVILEGES;
FLUSH TABLES WITH READ LOCK; #Prevents any changes to the data while you view the binary log position
SHOW MASTER STATUS; # Make a note of the values File (will be used to set MASTER_LOG_FILE) and Position (will be used to set MASTER_LOG_POS)
exit
```

```bash
mysqldump -u admin -p orca > orca-dump.sql
# sftp to slave
mysql -u admin -p
```

```sql
UNLOCK TABLES;
exit;
```

## Add this to master /etc/mysql/my.cnf of mysql (Slave)

`sudo vim /etc/mysql/my.cnf`:

```sql
server-id = 2
#bind-address = 127.0.0.1
```

```bash
{
sudo systemctl stop mariadb
sudo systemctl status mariadb
sudo systemctl start mariadb
sudo systemctl status mariadb
}
```

## Run these as 'admin' user on mysql (Slave)

Run `mysql -u admin -p` 

```sql
CREATE DATABASE orca;
GRANT ALL ON orca.* TO 'replication_user'@'localhost' IDENTIFIED BY 'repl1cat10n';
FLUSH PRIVILEGES;
```

Import the SQL dump from Master into SLAVE

```bash
mysql -u admin -p orca < orca-dump.sql
mysql -u admin -p
```

```sql
USE orca;
SHOW TABLES;
SELECT * FROM tasks;
CHANGE MASTER TO MASTER_HOST='10.11.0.6', MASTER_USER='replication_user', MASTER_PASSWORD='repl1cat10n', MASTER_LOG_FILE='mariadb-bin.000002', MASTER_LOG_POS=1535; # Put the proper IP address, MASTER_LOG_FILE and MASTER_LOG_POS values that you got from MariaDB Master
SHOW SLAVE STATUS\G;
START SLAVE;
SHOW SLAVE STATUS\G;
```

## Run these on the Master after Replication Setup

`mysql -u admin -p`:

```sql
USE orca;
INSERT INTO tasks (title, description) VALUES ('task2', 'This is a description for task 2');
INSERT INTO tasks (title, description) VALUES ('task3', 'This is a description for task 3');
INSERT INTO tasks (title, description) VALUES ('task4', 'This is a description for task 4');
```

## Run these on the Slave to check Replication

```sql
USE orca;
SELECT * FROM tasks;
```

## Configure TCP Proxy (OPTIONAL)

Assuming you are using a TCP Proxy (like Nginx) to route traffic to your MariaDB VMs, here's the configuration for the TCP Proxy in front of the MariaDB master instance:

```bash
    upstream mariadb-master-3306 {
        server 10.0.0.11:3306 max_fails=3 fail_timeout=10s;
    }

    server {
        listen 3306;
        proxy_pass mariadb-master-3306;
        proxy_next_upstream on;
    }
```

Here's the configuration for the TCP Proxy in front of the MariaDB slave instance:

```bash
    upstream mariadb-slave-3306 {
        server 10.0.0.33:3306 max_fails=3 fail_timeout=10s;
    }

    server {
        listen 3306;
        proxy_pass mariadb-slave-3306;
        proxy_next_upstream on;
    }
```
