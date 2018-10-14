# iptables

## Flush iptables

**OPTION 1:**

```bash
cat > $HOME/clear-all-rules << EOF
# Empty the entire filter table
*filter
:INPUT ACCEPT [0:0]
:FORWARD ACCEPT [0:0]
:OUTPUT ACCEPT [0:0]
COMMIT
EOF
sudo iptables-save > $HOME/firewall-rules-ipv4.txt
sudo ip6tables-save > $HOME/firewall-rules-ipv6.txt
sudo iptables-restore < $HOME/clear-all-rules
sudo ip6tables-restore < $HOME/clear-all-rules
```

**OPTION 2:**

```bash
sudo iptables -F
```

Check if the firewall rules are flushed...

```bash
sudo iptables -L -n -v
```
