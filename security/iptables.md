# iptables

#### Flush iptables
[Source](https://www.digitalocean.com/community/tutorials/how-to-setup-a-basic-ip-tables-configuration-on-centos-6)

If the VM contains some iptables configuration and you would like a clean slate:

```bash
sudo iptables -L -n (to list the current settings)
sudo iptables -F
sudo cat /etc/sysconfig/iptables (it should now be blank)
iptables-save | sudo tee /etc/sysconfig/iptables
sudo service iptables restart
```
