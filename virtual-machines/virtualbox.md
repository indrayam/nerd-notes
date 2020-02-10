# virtualbox

Source: [VirtualBox Network Settings: Complete Guide](https://www.nakivo.com/blog/virtualbox-network-setting-guide/)

### List VirtualBox VMs

```bash
vb list vms
vb list runningvms
vb list hostinfo
vb showvminfo <vmname|uuid> 
```

### Port Forwarding

```bash
# Stop the VM
# multipass stop <vm-name>
# VM named microk8s
sudo vboxmanage modifyvm "microk8s" --natpf1 "guestk8s,tcp,,16443,,16443"
sudo vboxmanage modifyvm "microk8s" --natpf1 delete guestk8s
# VM named k3s
sudo vboxmanage modifyvm "k3s" --natpf1 "guestk8s,tcp,,16443,,6443"
```
