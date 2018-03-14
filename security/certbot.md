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

### Process to obtaining SSL and manually configure Nginx

Pick one VM and update /etc/nginx/sites-enabled/default with the lines below:

```bash
location ^~ /.well-known/acme-challenge/ {
      default_type "text/plain";
      root /var/www/letsencrypt;
}
```
Here's a simple HTML file for `/www-root`:

```html
<html>
  <head>
    <title>Nginx Demo 1</title>
  </head>
  <body>
    <h3>Nginx Demo 1</h3>
  </body>
</html>
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

That's it! To check the fingerprint of the certificate (once uploaded to Digital Ocean), use this command:

```bash
openssl x509 -noout -sha1 -fingerprint -in cert1.pem
```

