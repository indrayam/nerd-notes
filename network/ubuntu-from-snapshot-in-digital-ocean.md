# Configure a new DO Droplet created from a snapshot (Ubuntu)
- Create a new [DigitalOcean](http://digitalocean.com) Droplet using the pre-existing snapshot
- After the Droplet has launched, access it using the "Console"
- Confirm that eth0 did not come up by running the following command. It should show an error message

```bash
sudo systemctl status networking.service
```
- Run `ip route` command to confirm the same
- Also, running `ifconfig -a` will show that eth0 never really came up. Instead, `ens3` is the network interface that was created. `dmesg | grep -i eth0` will show this name change event too
- Let's fix the Droplet name by editing the entries inside /etc/hosts and /etc/hostname files to reflect the new name that was selected during Droplet creation
- Let's fix the eth0 interface configuration. The reason why it did not come up was because the snapshot unfortunately preserves the IP address, Mac address, Hostname etc. configurations of the original Droplet that was used to create the snapshot. 
- Run `ifconfig -a` and copy the HW address for the `ens3` network interface
- Edit `/etc/network/interfaces.d/50-cloud-init.cfg` file's eth0 entries by updating the Public IP and Gateway entries to match the values for the new Droplet. The "Networking" section of the Digital Ocean console will tell you the Public IP and Gateway IP details for the new Droplet. Also, the DO Console tells that too at the bottom of the Console window
- Edit `/etc/udev/rules.d/70-persistent-net.rules` file by changing the `ATTR{address}` (for the line where `NAME="eth0"`) to reflect the HW address that was copied a few steps ago by running the `ifconfig -a` command: 

```bash
SUBSYSTEM=="net", ACTION=="add", DRIVERS=="?*", ATTR{address}=="06:8a:13:ad:46:00", NAME="eth0"
```
- Reboot and Log in to the console. Run the steps above to make sure that the `eth0` networking interface is up and running!
- Run `ip a show eth0` to confirm that the ip address is mapped correctly to the eth0 interface

**References:**
- [Failed to bring up eth0](https://www.digitalocean.com/community/questions/failed-to-bring-up-eth0)
- [Problem with updating Kernel (eth0 now missing)](https://www.digitalocean.com/community/questions/problem-with-updating-kernel-eth0-now-missing)
- [Ubuntu Network Configuration](https://help.ubuntu.com/lts/serverguide/network-configuration.html)
