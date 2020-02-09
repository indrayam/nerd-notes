# netstat

### Routing Table

```bash
netstat -r
```

### Finding if a particular port is in use on a host

```bash
netstat -tulpn | grep :8080
netstat -anv | grep .1024 # On Mac
```
