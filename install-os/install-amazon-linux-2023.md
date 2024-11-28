# Amazon Linux 2023

## Useful Commands

The default software package management tool in AL2023 is DNF. DNF is the successor to YUM, the package management tool in AL2.

```bash
# Version installed
cat /etc/os-release

# No amazon-linux-extras installed on Amazon Linux 2023
sudo dnf update
sudo dnf upgrade

# Current installed packages
sudo dnf --installed list

``` 