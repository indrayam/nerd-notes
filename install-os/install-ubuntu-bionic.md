# Setting up Ubuntu 18.04

## Unattended Upgrades

```bash
sudo apt update
sudo apt upgrade
sudo apt install unattended-upgrades apt-listchanges bsd-mailx
sudo dpkg-reconfigure -plow unattended-upgrades
sudo vi /etc/apt/apt.conf.d/50unattended-upgrades
```

Make these two edits (assuming you are working on dev instances):

```
...
Unattended-Upgrade::Mail "anasharm@cisco.com";
...
Unattended-Upgrade::Automatic-Reboot "true";
```

Save it. 

Edit `/etc/apt/listchanges.conf` with the following changes:

```
email_address=anasharm@cisco.com
```

Follow it up with a quick dry run:

```
sudo unattended-upgrades --dry-run
```

To check the status of the unattended upgrades, check:

```
sudo cat /var/log/unattended-upgrades/unattended-upgrades.log
```



