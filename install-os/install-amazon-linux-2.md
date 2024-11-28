# AWS (Amazon) Linux 2

## User Data

```bash
#!/bin/bash
yum update -y
yum install -y git
cd /home/ec2-user
curl -L -o run.sh https://bit.ly/39agoold
chown ec2-user.ec2-user run.sh
chmod +x run.sh
amazon-linux-extras install nginx1
yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
chown -R ec2-user.ec2-user /usr/share/nginx/html/
ln -s /usr/share/nginx/html/ html
chown -h ec2-user.ec2-user html
```

## User Data (Wordpress)

```bash
#!/bin/bash
yum update -y
yum install -y git httpd php php-mysql
cd /var/www/html
wget https://wordpress.org/wordpress-5.1.1.tar.gz
tar -xvzf wordpress-5.1.1.tar.gz
cp -r wordpress/* .
rm -rf wordpress
rm -f wordpress-5.1.1.tar.gz
chmod -R 755 wp-content
chown -R apache:apache /var/www/html
service httpd start
chkconfig httpd on
cd /home/ec2-user
curl -L -o run.sh https://bit.ly/39agoold
chown ec2-user:ec2-user run.sh
chmod +x run.sh
ln -s /var/www/html html
chown -h ec2-user:ec2-user html
```

```sql
select * from wp_options where option_name IN ('siteurl', 'home');
update wp_options set option_value='http://wp.indrayam.com' where option_name = 'siteurl';
update wp_options set option_value='http://wp.indrayam.com' where option_name = 'home';
flush tables;
select * from wp_options where option_name IN ('siteurl', 'home');
```

## Customize the Bash shell

```bash
sudo yum update -y
sudo yum install -y git 
curl -L -o run.sh https://bit.ly/39agoold
chmod +x run.sh
./run.sh
```

## Using amazon-linux-extras

```bash
amazon-linux-extras help
amazon-linux-extras list
amazon-linux-extras info nginx1
amazon-linux-extras install nginx1

```

## Enable EPEL Repo

```bash
sudo yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
sudo yum update -y
```

## Install Nginx

```bash
# using amazon-linux-extras
sudo amazon-linux-extras install nginx1

# OR

# using EPEL
sudo yum install nginx
```