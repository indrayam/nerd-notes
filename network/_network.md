# network scratchpad


### Network commands on a Mac
`networksetup`: Lots of useful network-centric commands

`networksetup -listallhardwareports`: You can run this command on a Mac to better understand the various interfaces that you see when you run ip link command

`networksetup -listnetworkserviceorder`: It produces similar output as the command above, but it displays "a list of network services in the order they are contacted for a connection" or it shows the services in the same order as System Preferences.

`defaults read /Library/Preferences/SystemConfiguration/NetworkInterfaces.plist`: Run this command to see further information about the `en` devices
