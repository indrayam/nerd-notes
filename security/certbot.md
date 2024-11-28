# certbot

### installing certbot on ubuntu

```bash
# Newer
sudo apt-get install certbot

# Older
sudo add-apt-repository ppa:certbot/certbot
sudo apt update
sudo apt install python-certbot-nginx
```

### Get SSL certificate (Manual)

```bash
sudo certbot certonly --manual -d indrayam.com
sudo certbot certonly --manual -d demo.indrayam.com
```

### Process to obtaining SSL and manually configure Nginx

Pick one VM and update /etc/nginx/sites-enabled/default with the lines below:

```bash
location ^~ /.well-known/acme-challenge/ {
      default_type "text/plain";
      root /var/www/letsencrypt;
}
```

Then, setup the folder as follows:

```bash
sudo mkdir -p /var/www/letsencrypt/.well-known/acme-challenge
```

Restart nginx:

```bash
sudo nginx -t
sudo systemctl restart nginx
```

Open two terminal windows to the server. On the first one, run certbot for generation of the certificates:

```bash

sudo certbot certonly --manual -d indrayam.com
```

When prompted like the following:

```bash
Create a file containing just this data:

abc.def

And make it available on your web server at this URL:

http://demo.indrayam.com/.well-known/acme-challenge/abc
```

Use the second terminal window to create a file `abc` and add the following content:

```bash
abc.def
```

That's it! To check the fingerprint of the certificate (once uploaded to Digital Ocean), use this command:

```bash
openssl x509 -noout -sha1 -fingerprint -in cert1.pem
```

