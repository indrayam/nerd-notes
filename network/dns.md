# dns

### Add a custom entry to /etc/hosts on Mac

```bash
# Add 127.0.0.1 kubernetes in /etc/hosts
dscacheutil -flushcache
sudo killall -HUP mDNSResponder
# Query the changes to /etc/hosts
dscacheutil -q host -a name kubernetes
```

### Notes

- hosts.txt
- BIND 10 and Microsoft DNS Server
- DNS is a 
    + Distributed database
    + Available Globally across the Internet
    + Partitioned into Zones
    + Managed in a decentralized way
    + Every database has an index
    + In DNS, the funny dotted names are the indexes
    + Domain Names are actually paths in an inverted tree
- Inverted Tree
    + A Computer Science data structure/concept
    + Made up of nodes and links between the nodes
    + Each node is connected to its parent by a single link
    + One node can be a parent to arbitrarily many children
- DNS Inverted Tree
    + Each node has a label, between zero and 63 bytes in length
    + The root node has a special, reserved label written as "" (zero-length label)
    + Other main restriction is that all the children of a single node have different labels


