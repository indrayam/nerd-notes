# mysql tools

## Post-Installation

```bash
sudo mysql_secure_installation
sudo systemctl status mariadb
```

## mysqladmin

```bash
sudo mysqladmin version
# OR
mysqladmin -u admin -p version
```


## mysql

```sql
GRANT ALL ON *.* TO 'admin'@'localhost' IDENTIFIED BY 'c0der0cks!' WITH GRANT OPTION;
FLUSH PRIVILEGES;
```
