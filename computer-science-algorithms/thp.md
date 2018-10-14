# Transparent Huge Pages (THP)

Source: [Disabling Transparent Huge Pages in Linux](https://www.stephenrlang.com/2018/01/disabling-transparent-huge-pages-in-linux/)

Transparent Huge Pages (THP) is a Linux memory management system that reduces the overhead of Translation Lookaside Buffer (TLB) lookups on machines with large amounts of memory by using larger memory pages.

However, database workloads often perform poorly with THP, because they tend to have sparse rather than contiguous memory access patterns. The overall recommendation for MySQL, MongoDB, Oracle, etc is to disable THP on Linux machines to ensure best performance.

```bash
sudo su
cat /sys/kernel/mm/transparent_hugepage/enabled
cat /sys/kernel/mm/transparent_hugepage/defrag
```

If the results show `[never]`, THP is disabled. If not, then do the following:

```bash
echo 'never' > /sys/kernel/mm/transparent_hugepage/enabled
echo 'never' > /sys/kernel/mm/transparent_hugepage/defrag
```

However once the system reboots, it will go back to its default value again. To make the setting persistent on CentOS 7 and Ubuntu 16.04, you can disable THP on system startup by making a systemd unit file:


```bash
sudo cat > /etc/systemd/system/disable-thp.service << EOF
[Unit]
Description=Disable Transparent Huge Pages (THP)

[Service]
Type=simple
ExecStart=/bin/sh -c "echo 'never' > /sys/kernel/mm/transparent_hugepage/enabled && echo 'never' > /sys/kernel/mm/transparent_hugepage/defrag"

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl start disable-thp
sudo systemctl enable disable-thp
```

For older versions of CentOS (6) and Ubuntu (14.04), you may add this to `/etc/rc.local` before the `exit 0` line:

```bash
...
if test -f /sys/kernel/mm/transparent_hugepage/enabled; then
   echo never > /sys/kernel/mm/transparent_hugepage/enabled
fi
if test -f /sys/kernel/mm/transparent_hugepage/defrag; then
   echo never > /sys/kernel/mm/transparent_hugepage/defrag
fi
...
```
