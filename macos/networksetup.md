# networksetup

[Source: mac network commands cheat sheet](https://gree2.github.io/mac/2015/07/18/mac-network-commands-cheat-sheet)

## Useful commands

```bash

# get ip address
ipconfig getifaddr en0

# get subnet mask
ipconfig getoption en0 subnet_mask

# get info about how en0 got its dhcp on
ipconfig getpacket en0

# get network info
ifconfig en0

# To find out which hw device is connected to en9, use the 2nd version
networksetup -listallnetworkservices
networksetup -listnetworkserviceorder

# Or use this version, it also shows Mac address
# List all hardware ports
networksetup -listallhardwareports

# networksetup -getmacaddress <hardwareport or device name>
networksetup -getmacaddress "Wi-Fi"

# get computer name
networksetup -getcomputername

# get details about a network service
# networksetup -getinfo <networkservice>
networksetup -getinfo "Wi-Fi"

# List preferred wireless networks
networksetup -listpreferredwirelessnetworks en0
```

