## mysql

1.

Create a Database and account(s)

```sql
GRANT ALL ON *.* TO 'admin'@'localhost' IDENTIFIED BY '...' WITH GRANT OPTION;
FLUSH PRIVILEGES;
SHOW DATABASES;
CREATE DATABASE orca;
DROP DATABASE orca;
GRANT ALL ON orca.* TO 'spinnaker'@'%' IDENTIFIED BY '...';
```

2. 

To get Server ID of MariaDB

```sql
SELECT @@server_id;
```
