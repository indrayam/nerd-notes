# AWS Ubuntu 20.04 (Focal Fossa)

## Basics

```bash
sudo apt-get update
sudo apt-get upgrade
cd /home/ubuntu
curl -L -o 39arun https://bit.ly/39ago
chown ubuntu.ubuntu 39arun
chmod +x 39arun
./39arun
```

## Nginx

```bash
sudo wget https://nginx.org/keys/nginx_signing.key
sudo apt-key add nginx_signing.key
sudo vim /etc/apt/sources.list.d/nginx.list

#Add the following lines to nginx.list:
deb [arch=amd64] http://nginx.org/packages/mainline/ubuntu/ focal nginx
deb-src http://nginx.org/packages/mainline/ubuntu/ focal nginx

sudo apt-get update
sudo apt-get install nginx
sudo nginx -t
sudo systemctl start nginx
sudo systemctl enable nginx
sudo systemctl status nginx

sudo chown -R ubuntu.ubuntu /usr/share/nginx/html
ln -s /usr/share/nginx/html html
sudo chown -h ubuntu.ubuntu html
```
