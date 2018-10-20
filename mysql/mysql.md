## mysql

```sql
GRANT ALL ON *.* TO 'admin'@'localhost' IDENTIFIED BY '...' WITH GRANT OPTION;
FLUSH PRIVILEGES;
SHOW DATABASES;
CREATE DATABASE orca;
DROP DATABASE orca;
GRANT ALL ON orca.* TO 'spinnaker'@'%' IDENTIFIED BY '...';
```
