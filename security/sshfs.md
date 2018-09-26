# sshfs

### Mount a remote folder on to your local laptop

[Reference: How To Use SSHFS to Mount Remote File Systems Over SSH](https://www.digitalocean.com/community/tutorials/how-to-use-sshfs-to-mount-remote-file-systems-over-ssh)

```bash
sudo sshfs -o allow_other,defer_permissions,IdentityFile=/Users/anasharm/.ssh/id_rsa ubuntu@spinnaker-code.cisco.com:/home/ubuntu /mnt/spinnaker-code
```
