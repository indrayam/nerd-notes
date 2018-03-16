# mtr

mtr combines the functionality of the traceroute and ping programs in a single network diagnostic tool. As mtr starts, it investigates the network connection between the host mtr runs on and HOSTNAME by send‐ ing  packets  with  purposely  low TTLs.  It continues to send packets with low TTL, noting the response time of the intervening routers.  This allows mtr to print the response percentage and response times of the  internet  route to HOSTNAME.  A sudden increase in packet loss or response time is often an indica‐ tion of a bad (or simply overloaded) link.

Source: [How To Use Traceroute and MTR to Diagnose Network Issues](https://www.digitalocean.com/community/tutorials/how-to-use-traceroute-and-mtr-to-diagnose-network-issues)

### Install mtr

```bash
sudo apt-get install mtr
```

### Usage examples

```bash
mtr google.com
mtr --report google.com
```

