# storage scratchpad

## How to mount volume into an Openstack VM

Source: 
- [Block Storage](https://docs.openstack.org/mitaka/install-guide-ubuntu/launch-instance-cinder.html)
- [OpenStack - Creating and Attaching a Volume into an Instance](http://www.darwinbiler.com/openstack-creating-and-attaching-a-volume-into-an-instance/)

```bash
# [OPTIONAL STEPS] openstack volume command gave an error in the older version
pip install python-openstackclient==3.16.1 
alias o='openstack'
o --version
# Start the volume creation and mounting steps
. ~/rtppoc
o volume create --size 200 hackmd
o server list
o server add volume hackmd hackmd # o server add volume <vm-name> <volume-name>
o volume list
```

SSH into the VM named <vm-instance-name> (in the above example, `hackmd`)

```bash
ssh ubuntu@hackmd
sudo fdisk -l # use the fdisk command to verify presence of the volume as the /dev/vdb block storage device
sudo mkdir -p /data
sudo fdisk -l /dev/vdb
sudo mkfs.ext4 /dev/vdb
sudo mount -o noatime /dev/vdb /opt/codimd-files
sudo vim /etc/fstab
# Add: 
# /dev/vdb /opt/codimd-files ext4 defaults,noatime 0 0
# OR
# /dev/disk/by-uuid/b489cce7-2ad6-4211-abea-0df68dc49d83 /code auto defaults,nofail 0 0
sudo reboot
```



