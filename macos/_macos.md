# MacOS specific commands

## Useful commands

```bash
# List Network Services
sudo networksetup -listallnetworkservices

# List DNS resolver
scutil --dns

# Flush local DNS cache
sudo dscacheutil -flushcache
sudo killall -HUP mDNSResponder

# Query for a DNS entry
dscacheutil -q host -a name indrayam.com
```