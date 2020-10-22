# AWS (Amazon) Linux 2

## Customize the Bash shell

```bash
sudo yum update -y
sudo yum install git
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