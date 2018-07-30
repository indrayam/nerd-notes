# cisco switch (ios)

List of Modes in Cisco IOS Switch:
- User Mode
- Privileged Mode
- Global Terminal Configuration Mode
- Interface Configuration Mode
- Line Configuration Mode

After entering the Privileged command, use `Exit` to go back one configuration level and `End` to go back straight to the Privileged Mode (`Switch#`). However, to go back from Privileged Mode to User Mode, you cannot use either. Instead, use `disable`.

`!` is used to make a line a comment in Cisco IOS

`Ctrl+K` - Deletes everything to the right of the cursor
`Ctrl+U` - Deletes everything to the left of the cursor
`Ctrl+X` - Delete entire line typed
`Ctrl+W` - Delete last word
`Ctrl+A` - Go to the start of the command typed
`Ctrl+E` - Go to the end of the command typed
`Ctrl+N` or `Down arrow` - Go forward in your history of commands
`Ctrl+P` or `Up arrow` - Go backward in your history of commands

### User Mode to Privileged Mode and back

```bash
Switch>enable OR 
Switch>en 
OR Switch>en<tab>
Switch#disable
Switch>
```

### Privileged Mode to Global Terminal Configuration Mode

```bash
Switch#configure terminal
OR
Switch#conf t
Switch(config)#exit
OR
Switch(config)#end
Switch#
```

### Global Terminal Configuration Mode to Interface Configuration Mode 

```bash
Switch(config)#interface vlan 1 
OR 
Switch(config)#int vlan 1
Switch(config-if)#exit
OR
Switch(config-if)#end
Switch#
```

### Global Terminal Configuration Mode to Line Configuration Mode

```bash
Switch(config)#line con 0 
OR 
Switch(config)#line vty 0 15
Switch(config-line)#exit
OR
Switch(config-line)#end
Switch#
```

### User Commands

```bash
Switch>?

Switch>show ver
Switch>show line
Switch>show line con 0

Switch>show mem

Switch>show history

Switch>show ip interface brief
Switch>show int FastEthernet 0/1
OR
Switch>show int Fa 0/1
OR
Switch>show int Fa0/1

```

### Privileged Commands
All User Commands listed above can be invoked in Privileged mode.

```bash
Switch#?

Switch#show running-config
OR
Switch#show run

Switch#show 

```

### Global Terminal Configuration Commands

```bash
Switch(config)#?

Switch(config)#ip default-gateway 192.168.1.1 255.255.255.0
```

### Interface Configuration Commands

```bash
Switch(config-if)#?

Switch(config-if)#ip address 192.168.1.11 255.255.255.0
Switch(config-if)#no shutdown

```

### Line Configuration Commands

```bash
Switch(config-line)#?

Switch(config-line)#password cisco
Switch(config-line)#login

Switch(config-line)#transport input all 
OR
Switch(config-line)#transport input telnet
OR
Switch(config-line)#transport input ssh
OR
Switch(config-line)#transport input none

Switch(config-line)#history size 100

```

