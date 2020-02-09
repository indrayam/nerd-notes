# virtualbox

### List VirtualBox VMs

```bash
vb list vms
vb list hostinfo
vb showvminfo <vmname|uuid> 
```

### Port Forwarding

```bash
# Stop the VM
# multipass stop <vm-name>
sudo vboxmanage modifyvm "microk8s" --natpf1 "guestk8s,tcp,,16443,,16443"
sudo vboxmanage modifyvm "microk8s" --natpf1 delete guestk8s
```
