# mysql tools

## Installation

```bash
./openstack-create rcdnplay mariadb-db1 mariadb
./openstack-create rcdnplay mariadb-db2 mariadb
```

## Post-Installation (Both MariaDB instances)
./complete-mariadb-setup.sh

Running this script above will run the steps below. Make sure not to change `root` password.

```bash
sudo mysql_secure_installation
sudo systemctl status mariadb
sudo mysql
```

Create a new admin account for all MariaDB administration tasks.

```sql
GRANT ALL ON *.* TO 'admin'@'localhost' IDENTIFIED BY 'password' WITH GRANT OPTION;
FLUSH PRIVILEGES;
exit;
```

## Steps to run on MySQL Master

### Add this to master /etc/mysql/my.cnf of mysql (Master)

`sudo vim /etc/mysql/my.cnf`:

```sql
[mysqld]
...
server-id = 1
#bind-address = 127.0.0.1
replicate-do-db=orca
...
```

```bash
sudo systemctl stop mariadb
sudo systemctl status mariadb
sudo systemctl start mariadb
sudo systemctl status mariadb
```

### Run these as 'admin' user on the mysql (Master)

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

## MySQL Slave

### Add this to master /etc/mysql/my.cnf of mysql (Slave)

`sudo vim /etc/mysql/my.cnf`:

```sql
server-id = 2
#bind-address = 127.0.0.1
```

```bash
sudo systemctl stop mariadb
sudo systemctl status mariadb
sudo systemctl start mariadb
sudo systemctl status mariadb
```

### Run these as 'admin' user on mysql (Slave)

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
CHANGE MASTER TO MASTER_HOST='10.10.0.20', MASTER_USER='replication_user', MASTER_PASSWORD='repl1cat10n', MASTER_LOG_FILE='mariadb-bin.000002', MASTER_LOG_POS=1551; # Put the proper IP address, MASTER_LOG_FILE and MASTER_LOG_POS values that you got from MariaDB Master
SHOW SLAVE STATUS\G;
START SLAVE;
SHOW SLAVE STATUS\G;
```

### Run these ONLY AFTER Slave has been setup

```sql
INSERT INTO tasks (title, description) VALUES ('task2', 'This is a description for task 2');
INSERT INTO tasks (title, description) VALUES ('task3', 'This is a description for task 3');
INSERT INTO tasks (title, description) VALUES ('task4', 'This is a description for task 4');
INSERT INTO tasks (title, description) VALUES ('task45', 'This is a description for task 45');
```
