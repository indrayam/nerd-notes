# systemd, systemctl, service, chkconfig

An init system that manages how daemons stop, start and restart. It also manages which of these processes come up when the operating system is restarted. Used to be `SysVinit` for a long time. Ubuntu used to use `upstart` for a few years. However, now most Linux distributions have converged on `systemd`

Btw, `systemd` calls these daemons as "units". `systemctl` command is the systemd control command that allows us to control everything

### systemctl

- `systemctl status ssh[.service]`: List the status of the service/unit
- `sudo systemctl start ssh[.service]`: Start the service/unit
- `sudo systemctl stop ssh[.service]`: Stop the service/unit
- `sudo systemctl restart ssh[.service]`: Restart the service/unit
- `sudo systemctl enable ssh[.service]`: If you want the service to start when the system restarts, run this command
- `sudo systemctl disable ssh[.service]`: If you **DO NOT** want the service to start when the system restarts, run this command
- `systemctl list-units`: List all daemons/processes running, including sockets and slice (whatever that is)
- `systemctl list-units | grep -i .service`: List all "true" daemons/processes running, since they all end in ".service"
- `systemctl --failed` lists all the services/units that failed during startup
- `systemctl is-enabled ssh[.service]`
- `sudo systemctl daemon-reload` 
- `sudo systemctl reboot`
- `sudo systemctl poweroff`
- `sudo systemctl suspend`
- `journalctl` To look at logs from the services/units
- `journalctl -b` To look at logs from the system boot
- `journalctl -u <unit-name>` To look at logs for a specific service

### Sample system service file

To create a `systemd` unit file, create `<service-name>.service` file in `/etc/systemd/system` folder with content that looks like the following. Obviously, change the `ExecStart` and `ExecStop` entries to adapt it to the service in question

```bash
[Unit]
Description=Redis In-Memory Data Store
After=network.target

[Service]
User=redis
Group=redis
# Use the setting below to increate max open files setting for this service
LimitNOFILE=65536
ExecStart=/usr/local/bin/redis-server /etc/redis/6379/redis.conf
ExecStop=/usr/local/bin/redis-cli shutdown
Restart=always

[Install]
WantedBy=multi-user.target
```

```bash
[Unit]
Description=Disable Transparent Huge Pages (THP)

[Service]
Type=simple
ExecStart=/bin/sh -c "echo 'never' > /sys/kernel/mm/transparent_hugepage/enabled && echo 'never' > /sys/kernel/mm/transparent_hugepage/defrag"

[Install]
WantedBy=multi-user.target
```
### chkconfig
[Source](https://access.redhat.com/site/documentation/en-US/Red_Hat_Enterprise_Linux/6/html/Deployment_Guide/s2-services-chkconfig.html)

```bash
chkconfig --add <service-name>
chkconfig --level 235 <service-name> on
chkconfig --list
```
