# certbot

### installing certbot on ubuntu

```bash

sudo add-apt-repository ppa:certbot/certbot
sudo apt update
sudo apt install python-certbot-nginx
```

### Obtaining an SSL certificate

```bash
sudo certbot --nginx -d indrayam.com -d www.indrayam.com
```

### Certificate Auto-Renewal

```bash
certbot renew --dry-run
```

### Obtaining SSL without configuring a web server

Pick one VM and update /etc/nginx/sites-enabled/default with the lines below:

```bash
        location ^~ /.well-known/acme-challenge/ {
              default_type "text/plain";
              root /var/www/letsencrypt;
        }
```

Then, setup the folder as follows:

```bash
mkdir -p /var/www/letsencrypt/.well-known/acme-challenge
```

Restart nginx:

```bash
sudo nginx -t
sudo systemctl restart nginx
```

Run certbot for generation of the certificates:

```bash

certbot certonly --manual -d demo.indrayam.com
```

When prompted like the following:

```bash
Create a file containing just this data:

abc.def

And make it available on your web server at this URL:

http://demo.indrayam.com/.well-known/acme-challenge/abc
```

Create a file `abc` and add the following content:

```
abc.def
```

That's it!

