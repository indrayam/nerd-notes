# certbot

### installing certbot

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


