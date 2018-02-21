# certbot

### installing certbot on ubuntu

```bash

sudo add-apt-repository ppa:certbot/certbot
sudo apt update
sudo apt install python-certbot-nginx
```

### Obtaining an SSL certificate

```bash
sudo certbot --nginx -d example.com -d www.example.com
```

### Certificate Auto-Renewal

```bash
certbot renew --dry-run
```


