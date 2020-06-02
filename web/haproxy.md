# haproxy

## References
- [The Four Essential Sections of an HAProxy Configuration](https://www.haproxy.com/blog/the-four-essential-sections-of-an-haproxy-configuration/)
- [HA Proxy Configuration Manual](https://cbonte.github.io/haproxy-dconv/1.7/configuration.html#2.5)
- [HAProxy redirect traffic to NGINX getting error "The plain HTTP request was sent to HTTPS port"](https://serverfault.com/questions/701580/haproxy-redirect-traffic-to-nginx-getting-error-the-plain-http-request-was-sent/701584)
- [HAproxy 1.5 Trusted CAs](https://serverfault.com/questions/623045/haproxy-1-5-trusted-cas)
- [Server for Hackers: Using SSL Certificates with HAProxy](https://serversforhackers.com/c/using-ssl-certificates-with-haproxy)
- [Server for Hackers: Load Balancing with HAProxy](https://serversforhackers.com/c/load-balancing-with-haproxy)
- [Install And Configure HAProxy Load Balancer On Ubuntu 16.04](https://devops.ionos.com/tutorials/install-and-configure-haproxy-load-balancer-on-ubuntu-1604/)

## HA Proxy Logs

- HA Proxy logs are available at `/var/log/haproxy.log`

## Default portion for all configurations

```
global
	log /dev/log	local0
	log /dev/log	local1 notice
	chroot /var/lib/haproxy
	stats socket /run/haproxy/admin.sock mode 660 level admin expose-fd listeners
	stats timeout 30s
	user haproxy
	group haproxy
	daemon

	# Default SSL material locations
	ca-base /etc/ssl/certs
	crt-base /etc/ssl/private

	# Default ciphers to use on SSL-enabled listening sockets.
	# For more information, see ciphers(1SSL). This list is from:
	#  https://hynek.me/articles/hardening-your-web-servers-ssl-ciphers/
	# An alternative list with additional directives can be obtained from
	#  https://mozilla.github.io/server-side-tls/ssl-config-generator/?server=haproxy
	ssl-default-bind-ciphers ECDH+AESGCM:DH+AESGCM:ECDH+AES256:DH+AES256:ECDH+AES128:DH+AES:RSA+AESGCM:RSA+AES:!aNULL:!MD5:!DSS
	ssl-default-bind-options no-sslv3

defaults
	log	global
	mode	http
	option	httplog
	option	dontlognull
        timeout connect 5000
        timeout client  50000
        timeout server  50000
	errorfile 400 /etc/haproxy/errors/400.http
	errorfile 403 /etc/haproxy/errors/403.http
	errorfile 408 /etc/haproxy/errors/408.http
	errorfile 500 /etc/haproxy/errors/500.http
	errorfile 502 /etc/haproxy/errors/502.http
	errorfile 503 /etc/haproxy/errors/503.http
	errorfile 504 /etc/haproxy/errors/504.http
```

## Sample HA Proxy Configuration 1

```
frontend http-in
    bind *:80
    default_backend servers

backend servers
    server server1 news.ycombinator.com:80 maxconn 32
```

## Sample HA Proxy Configuration 2

```
frontend http-in
    bind *:80
    bind *:443
    option tcplog
    mode tcp
    default_backend servers

backend servers
    mode tcp
    option ssl-hello-chk
    server server1 news.ycombinator.com:443 check
```

## Sample HA Proxy Configuration 3

```
frontend http-in
    bind *:80
    default_backend servers

backend servers
    option forwardfor
    server server1 news.ycombinator.com:443 ssl verify none
```

## Sample HA Proxy Configuration 4

```
frontend http-in
    bind *:80
    default_backend servers

backend servers
    server server1 cisco.com:443 ssl verify none
```

## Sample HA Proxy Configuration 5

```
frontend http-in
    bind *:80
    default_backend servers

backend servers
    server server1 cisco.com:443 ssl verify required ca-file ca-certificates.crt
```
