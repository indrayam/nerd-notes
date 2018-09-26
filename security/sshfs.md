# sshfs

### Mount a remote folder on to your local laptop

```bash
sudo sshfs -o allow_other,defer_permissions,IdentityFile=/Users/anasharm/.ssh/id_rsa ubuntu@spinnaker-code.cisco.com:/home/ubuntu /mnt/spinnaker-code
```
