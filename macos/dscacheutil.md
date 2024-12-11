# dscacheutil

## Flush Local DNS Cache

```bash
# Flush local DNS cache
sudo dscacheutil -flushcache
sudo killall -HUP mDNSResponder

# Query for a DNS entry
dscacheutil -q host -a name indrayam.com
```