# dns clients

### Add a custom entry to /etc/hosts on Mac

```bash
# Add 127.0.0.1 kubernetes in /etc/hosts
dscacheutil -flushcache
sudo killall -HUP mDNSResponder
# Query the changes to /etc/hosts
dscacheutil -q host -a name kubernetes
```
