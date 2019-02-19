# security scratchpad

## Create a CSR

```bash
openssl req -nodes -newkey rsa:2048 -keyout hackmd.key -out hackmd.csr
# This will prompt you for a passphrase. You will need to pass this everytime you (re)start Nginx
openssl rsa -des3 -in hackmd.key -out hackmd.key.new 
mv hackmd.key.new hackmd.key
```

## Submit the CSR to sslcerts.cisco.com

- Open [Cisco SSL Certs](https://sslcerts.cisco.com/sslrequest/)
- Click on "Request Certificate"
- `cat hackmd.csr` and paste it into the CSR text area
- Once your manager approves the request and you get the cert, download all 3 certs:
    + Certificate (PEM)
    + Issuing CA (PEM)
    + Root CA (PEM)
- Concatenate all 3 PEM files into 1 file in the same sequence as above
- Let's call that file `hackmd_StackedChain.pem`
- Upload the files to Nginx and store it in `/etc/nginx/ssl/`
- Create a file called `hackmd.pass` in `/etc/nginx/ssl/`
- Store the DES3 passphrase in the file `hackmd.pass`
- Create `/etc/nginx/conf.d/hackmd-http.conf`:

```bash
# Default server configuration

server {
    listen 80 default_server;
    listen [::]:80 default_server;
    server_name hackmd.cisco.com;
    return 301 https://$server_name$request_uri;

}
```

- Create `/etc/nginx/conf.d/hackmd-https.conf`: Note the use of `ssl_password_file` to enter passphrase at startup-time

```bash
# Virtual Host configuration for example.com
#
server {
  listen 443 ssl;
  ssl_password_file /etc/nginx/ssl/hackmd.pass;
  ssl_certificate_key /etc/nginx/ssl/hackmd.key;
  ssl_certificate /etc/nginx/ssl/hackmd_StackedChain.pem;

  server_name hackmd.cisco.com;

  proxy_set_header HOST $host;
  proxy_set_header X-Forwarded-Proto $scheme;
  proxy_set_header X-Real-IP $remote_addr;
  proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
  proxy_http_version 1.1;
  proxy_request_buffering off;

  location ~ ^/(home|toc) {
    return 301 https://$server_name/Jcw04-U6SLSyEdTSG37x6A;
  }

  location / {
    proxy_pass http://127.0.0.1:3000;
  }
}
```

- `sudo nginx -t`
- `sudo systemctl status nginx`
- `sudo systemctl stop nginx`
- `sudo systemctl start nginx`



