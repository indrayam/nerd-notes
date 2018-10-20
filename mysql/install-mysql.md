# mysql tools

## Post-Installation

```bash
sudo mysql_secure_installation
sudo systemctl status mariadb
```

## MySQL Master

### Add this to master /etc/mysql/my.cnf of mysql (Master)

```sql
replicate-do-db=orca
#bind-address = 127.0.0.1
sudo systemctl stop mariadb
sudo systemctl start mariadb

CREATE TABLE IF NOT EXISTS tasks (
    task_id INT AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    PRIMARY KEY (task_id)
)  ENGINE=INNODB;
INSERT INTO tasks (title, description) VALUES ('task1', 'This is a description for task 1');
FLUSH TABLES WITH READ LOCK;
```

### Run these as 'admin' user on the mysql (Master)

```sql
GRANT ALL ON orca.* TO 'spinnaker'@'%' IDENTIFIED BY '0rcar0cks!';
GRANT REPLICATION SLAVE ON *.* TO 'replication_user'@'10.11.0.14' IDENTIFIED BY 'repl1cat10n';
GRANT REPLICATION SLAVE ON *.* TO 'replication_user'@'mariadb-db2.cisco.com' IDENTIFIED BY 'repl1cat10n';
FLUSH PRIVILEGES;
FLUSH TABLES WITH READ LOCK; #Prevents any changes to the data while you view the binary log position
SHOW MASTER STATUS;
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

### After Slave has been setup

```sql
INSERT INTO tasks (title, description) VALUES ('task2', 'This is a description for task 2');
INSERT INTO tasks (title, description) VALUES ('task3', 'This is a description for task 3');
INSERT INTO tasks (title, description) VALUES ('task4', 'This is a description for task 4');
INSERT INTO tasks (title, description) VALUES ('task45', 'This is a description for task 45');
```

## MySQL Slave

### Add this to master /etc/mysql/my.cnf of mysql (Slave)

```bash
replicate-do-db=orca
#bind-address = 127.0.0.1
sudo systemctl stop mariadb
sudo systemctl start mariadb
```

### Run these as 'admin' user on mysql (Slave)

```sql
CREATE DATABASE tasks;
GRANT ALL ON orca.* TO 'replication_user'@'localhost' IDENTIFIED BY 'repl1cat10n';
FLUSH PRIVILEGES;
```

```bash
> mysql -u admin -p orca < orca-dump.sql
```

```sql
CHANGE MASTER TO MASTER_HOST='10.11.0.12', MASTER_USER='replication_user', MASTER_PASSWORD='repl1cat10n', MASTER_LOG_FILE='mariadb-bin.000004', MASTER_LOG_POS=878;
START SLAVE;
SHOW SLAVE STATUS\G;
```

