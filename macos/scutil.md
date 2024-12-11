# scutil

## List DNS resolver

```bash
scutil --dns

# Need to understand this ouput 

## Output shown below is when the WiFi is connected to blizzard

# DNS configuration

# resolver #1
#   search domain[0] : cisco.com
#   nameserver[0] : 72.163.47.11
#   nameserver[1] : 173.36.131.10
#   if_index : 16 (en0)
#   flags    : Request A records
#   reach    : 0x00000002 (Reachable)

# resolver #2
#   domain   : local
#   options  : mdns
#   timeout  : 5
#   flags    : Request A records
#   reach    : 0x00000000 (Not Reachable)
#   order    : 300000

# resolver #3
#   domain   : 254.169.in-addr.arpa
#   options  : mdns
#   timeout  : 5
#   flags    : Request A records
#   reach    : 0x00000000 (Not Reachable)
#   order    : 300200

# resolver #4
#   domain   : 8.e.f.ip6.arpa
#   options  : mdns
#   timeout  : 5
#   flags    : Request A records
#   reach    : 0x00000000 (Not Reachable)
#   order    : 300400

# resolver #5
#   domain   : 9.e.f.ip6.arpa
#   options  : mdns
#   timeout  : 5
#   flags    : Request A records
#   reach    : 0x00000000 (Not Reachable)
#   order    : 300600

# resolver #6
#   domain   : a.e.f.ip6.arpa
#   options  : mdns
#   timeout  : 5
#   flags    : Request A records
#   reach    : 0x00000000 (Not Reachable)
#   order    : 300800

# resolver #7
#   domain   : b.e.f.ip6.arpa
#   options  : mdns
#   timeout  : 5
#   flags    : Request A records
#   reach    : 0x00000000 (Not Reachable)
#   order    : 301000

# DNS configuration (for scoped queries)

# resolver #1
#   search domain[0] : cisco.com
#   nameserver[0] : 72.163.47.11
#   nameserver[1] : 173.36.131.10
#   if_index : 16 (en0)
#   flags    : Scoped, Request A records
#   reach    : 0x00000002 (Reachable)

## Output shown below is when the WiFi is connected to ISP network (Spectrum)

# DNS configuration

# resolver #1
#   search domain[0] : search.charter.net
#   nameserver[0] : 2001:1998:f00:2::1
#   nameserver[1] : 2001:1998:f00:1::1
#   nameserver[2] : 2603:8080:2200:21cf:3a94:edff:fe56:6f8d
#   nameserver[3] : 192.168.1.1
#   if_index : 16 (en0)
#   flags    : Request A records, Request AAAA records
#   reach    : 0x00000002 (Reachable)

# resolver #2
#   domain   : local
#   options  : mdns
#   timeout  : 5
#   flags    : Request A records, Request AAAA records
#   reach    : 0x00000000 (Not Reachable)
#   order    : 300000

# resolver #3
#   domain   : 254.169.in-addr.arpa
#   options  : mdns
#   timeout  : 5
#   flags    : Request A records, Request AAAA records
#   reach    : 0x00000000 (Not Reachable)
#   order    : 300200

# resolver #4
#   domain   : 8.e.f.ip6.arpa
#   options  : mdns
#   timeout  : 5
#   flags    : Request A records, Request AAAA records
#   reach    : 0x00000000 (Not Reachable)
#   order    : 300400

# resolver #5
#   domain   : 9.e.f.ip6.arpa
#   options  : mdns
#   timeout  : 5
#   flags    : Request A records, Request AAAA records
#   reach    : 0x00000000 (Not Reachable)
#   order    : 300600

# resolver #6
#   domain   : a.e.f.ip6.arpa
#   options  : mdns
#   timeout  : 5
#   flags    : Request A records, Request AAAA records
#   reach    : 0x00000000 (Not Reachable)
#   order    : 300800

# resolver #7
#   domain   : b.e.f.ip6.arpa
#   options  : mdns
#   timeout  : 5
#   flags    : Request A records, Request AAAA records
#   reach    : 0x00000000 (Not Reachable)
#   order    : 301000

# DNS configuration (for scoped queries)

# resolver #1
#   search domain[0] : search.charter.net
#   nameserver[0] : 2001:1998:f00:2::1
#   nameserver[1] : 2001:1998:f00:1::1
#   nameserver[2] : 2603:8080:2200:21cf:3a94:edff:fe56:6f8d
#   nameserver[3] : 192.168.1.1
#   if_index : 16 (en0)
#   flags    : Scoped, Request A records, Request AAAA records
#   reach    : 0x00000002 (Reachable)
```