# virtual machines scratchpad


### Setup Notes
- Running `ps aux|grep -i vmnet` shows all the vmware services running on MacOSX to support things like DHCP, NAT etc.
- `vmhgfs-fuse .host:/Dropbox /home/anand/Dropbox` to mount shared folders in Ubuntu or CentOS Gues OS running inside VMWare Fusion [Source 1](http://notesofaprogrammer.blogspot.com/2016/11/mounting-shared-directory-at-host-using.html)
- `sudo mount -t vmhgfs .host:/Dropbox /home/anand/Dropbox` to mount shared folders in CentOS running inside VMWare Fusion [Source 1](https://pubs.vmware.com/workstation-9/index.jsp#com.vmware.ws.using.doc/GUID-AB5C80FE-9B8A-4899-8186-3DB8201B1758.html) and [Source 2](https://askubuntu.com/questions/29284/how-do-i-mount-shared-folders-in-ubuntu-using-vmware-tools). For some reason, this command gives an error on Ubuntu 16.04.3 LTS
- In order to mount the shared folders at boot time, add the lines in `/etc/fstab` using the following format:

```bash
.host:/shared_foo /mnt/hgfs/foo fuse.vmhgfs-fuse allow_other,uid=foo_user,gid=foo_group,umask=022 0 0
```

Here's the entry I have in my two Linux Guest OS:

```bash
.host:/Dropbox /home/anand/Dropbox fuse.vmhgfs-fuse allow_other,uid=anand,gid=anand 0 0
.host:/macos-downloads /home/anand/macos-downloads fuse.vmhgfs-fuse allow_other,uid=anand,gid=anand 0 0
```


### References
- [1026510](https://kb.vmware.com/s/article/1026510) Modifying the DHCP settings of `vmnet1` and `vmnet8` in VMWare Fusion
- [VMWare Fusion Docs](https://docs.vmware.com/en/VMware-Fusion/index.html)
- [Understanding networking types in VMWare Fusion](https://kb.vmware.com/s/article/1022264?r=2&Quarterback.validateRoute=1&KM_Utility.getArticleData=1&KM_Utility.getGUser=1&KM_Utility.getArticleLanguage=1&KM_Utility.getArticle=1)
- Setting a static IP Address in VMWare Fusion: [Source1](https://willwarren.com/2015/04/02/set-static-ip-address-in-vmware-fusion-7/), [Source2](http://henokmikre.com/blog/2015/09/vmware-static-ip), [Source3](https://spin.atomicobject.com/2017/04/03/vmware-fusion-custom-virtual-networks/) and [Source4](https://www.craig-wright.com/2012/12/01/vmware-fusion-networking-tips-and-tricks/)
- [Overview of VMWare Tools for VMWare Fusion](https://kb.vmware.com/s/article/1022048?r=2&Quarterback.validateRoute=1&KM_Utility.getArticleData=1&KM_Utility.getGUser=1&KM_Utility.getArticleLanguage=1&KM_Utility.getArticle=1)
- [Installing VMware Tools in a Linux virtual machine using a Compiler](https://kb.vmware.com/s/article/1018414)

