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

3.

Get Current User

```sql
SELECT USER(), CURRENT_USER();
```

4. Installing MariaDB on my Mac:

On local MariaDB, these are the commands I ran to install MariaDB:

```bash
brew install mariadb
mysql.server start
# brew services start mariadb
# brew services stop mariadb
mysql -u root
```

Unfortunately, `mysql.server start` command would not work :sad:

To figure out the issue, I ran `my_print_defaults` from `/usr/local/Cellar/mariadb/10.3.15/bin` folder. Output said something like...

```
...
Default options are read from the following files in the given order:
/usr/local/etc/my.cnf ~/.my.cnf
...
```

While I did have `/usr/local/etc/my.cnf`, it was referring to the following:

```
...
#
# include all files from the config directory
#
!includedir /usr/local/etc/my.cnf.d
```

And there was no `/usr/local/etc/my.cnf.d` folder. Hence the error while running `mysql.server` command. Created `/usr/local/etc/my.cnf.d` and copied `my.cnf.default` into this new folder and renamed it to `my.cnf`. Things worked like a charm!

```sql
CREATE DATABASE hr;
DROP USER jpa@localhost;
CREATE USER jpa@localhost IDENTIFIED BY 'java';
GRANT ALL PRIVILEGES ON hr.* TO 'jpa'@'localhost' IDENTIFIED BY 'java';
```

Note:
MySQL JDBC driver had a [BUG](https://community.microstrategy.com/s/article/KB442386-The-server-time-zone-value-EDT-is-unrecognized-or-represents-more-than-one-time-zone-error-appears-with-MySQL-JDBC-Driver-in-MicroStrategy-10-4-x-and-above?language=en_US) which was also causing issues when running my Groovy code
