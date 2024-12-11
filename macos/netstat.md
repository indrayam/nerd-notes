# netstat

## Useful Commands

```bash

# statistics for network interfaces
netstat -i

# Routing Table
netstat -nr

# Need to understand the output more
# For example:

# Routing tables

# Internet:
# Destination        Gateway            Flags               Netif Expire
# default            192.168.1.1        UGScg                 en0       
# default            link#25            UCSIg           bridge100      !
# 127                127.0.0.1          UCS                   lo0       
# 127.0.0.1          127.0.0.1          UH                    lo0       
# 169.254            link#16            UCS                   en0      !
# 169.254            link#16            UCSI                  en0      !
# 192.168.1          link#16            UCS                   en0      !
# 192.168.1          link#16            UCSI                  en0      !
# 192.168.1.1/32     link#16            UCS                   en0      !
# 192.168.1.1        38:94:ed:56:6f:8d  UHLWIir               en0   1148
# 192.168.1.1/32     link#16            UCSI                  en0      !
# 192.168.1.4        c4:4f:33:a7:c4:8c  UHLWI                 en0   1193
# 192.168.1.6        78:db:2f:d9:32:97  UHLWI                 en0   1200
# 192.168.1.15       84:d:8e:7a:35:86   UHLWI                 en0   1198
# 192.168.1.17       4a:e1:17:a:3:57    UHLWIi                en0   1149
# 192.168.1.22       c8:d0:83:d4:23:72  UHLWIi                en0   1148
# 192.168.1.26       22:a7:36:e6:87:a8  UHLWI                 en0   1147
# 192.168.1.27       9e:8b:55:76:46:60  UHLWIi                en0   1149
# 192.168.1.63       c4:4f:33:9e:1d:cd  UHLWI                 en0   1199
# 192.168.1.67/32    link#16            UCS                   en0      !
# 192.168.1.67       9e:23:3f:4:51:e2   UHLWI                 lo0       
# 192.168.1.255      ff:ff:ff:ff:ff:ff  UHLWbI                en0      !
# 192.168.105        link#25            UC              bridge100      ! <== This seems to be related to Multi-Pass. Am I right?
# 192.168.105.1      be.d0.74.35.b3.64  UHLWIi                lo0       
# 192.168.105.9      52.54.0.4a.22.af   UHLWIi          bridge100   1159  <== This is the IP address of the Ubuntu VM running in Multi-Pass
# 192.168.105.255    ff.ff.ff.ff.ff.ff  UHLWbI          bridge100      !
# 224.0.0/4          link#16            UmCS                  en0      !
# 224.0.0.251        1:0:5e:0:0:fb      UHmLWI                en0       
# 224.0.0.251        1:0:5e:0:0:fb      UHmLWIg         bridge100       
# 255.255.255.255/32 link#16            UCS                   en0      !
# 255.255.255.255    ff:ff:ff:ff:ff:ff  UHLWbI                en0      !

# Internet6:
# Destination                             Gateway                                 Flags               Netif Expire
# default                                 fe80::3a94:edff:fe56:6f8d%en0           UGcg                  en0       
# default                                 fe80::%utun0                            UGcIg               utun0       
# default                                 fe80::%utun1                            UGcIg               utun1       
# default                                 fe80::%utun2                            UGcIg               utun2       
# default                                 fe80::%utun3                            UGcIg               utun3       
# default                                 fe80::%utun4                            UGcIg               utun4       
# default                                 fe80::%utun5                            UGcIg               utun5       
# ::1                                     ::1                                     UHL                   lo0       
# 2603:8080:2200:21cf::/64                link#16                                 UC                    en0       
# 2603:8080:2200:21cf:ca6:a5a3:83c:1413   9e:23:3f:4:51:e2                        UHL                   lo0       
# 2603:8080:2200:21cf:3a94:edff:fe56:6f8d 38:94:ed:56:6f:8d                       UHLWIi                en0       
# 2603:8080:2200:21cf:4935:2786:d23b:b35b 9e:23:3f:4:51:e2                        UHL                   lo0       
# fd06:5163:2f29:9cc4::/64                link#25                                 UC              bridge100       
# fd06:5163:2f29:9cc4::                   link#25                                 UHLWI           bridge100       
# fd06:5163:2f29:9cc4:18c4:ecc:dd39:ff0a  be.d0.74.35.b3.64                       UHL                   lo0       
# fd9c:86f9:1510::/64                     fe80::1c54:8ee0:88d6:1218%en0           UGc                   en0       
# fe80::%lo0/64                           fe80::1%lo0                             UcI                   lo0       
# fe80::1%lo0                             link#1                                  UHLI                  lo0       
# fe80::%en0                              link#16                                 UHLWI                 en0       
# fe80::%en0/64                           link#16                                 UCI                   en0       
# fe80::5a:5bb6:3612:c631%en0             22:a7:36:e6:87:a8                       UHLWIi                en0       
# fe80::497:444b:5477:29c6%en0            4a:e1:17:a:3:57                         UHLWI                 en0       
# fe80::8b6:e404:987f:2312%en0            9e:23:3f:4:51:e2                        UHLI                  lo0       
# fe80::8f1:7cc1:5a2a:a8ac%en0            c8:d0:83:d4:23:72                       UHLWI                 en0       
# fe80::18df:9e56:7662:5141%en0           9e:8b:55:76:46:60                       UHLWI                 en0       
# fe80::1c54:8ee0:88d6:1218%en0           f0:b3:ec:32:e7:d2                       UHLWIi                en0       
# fe80::3a94:edff:fe56:6f8d%en0           38:94:ed:56:6f:8d                       UHLWIir               en0       
# fe80::6857:33ff:febf:4cd6%awdl0         6a:57:33:bf:4c:d6                       UHLI                  lo0       
# fe80::6857:33ff:febf:4cd6%llw0          6a:57:33:bf:4c:d6                       UHLI                  lo0       
# fe80::%utun0/64                         fe80::d5:1cf3:555a:a53%utun0            UcI                 utun0       
# fe80::d5:1cf3:555a:a53%utun0            link#20                                 UHLI                  lo0       
# fe80::%utun1/64                         fe80::6411:ee8f:ffc6:dbfa%utun1         UcI                 utun1       
# fe80::6411:ee8f:ffc6:dbfa%utun1         link#21                                 UHLI                  lo0       
# fe80::%utun2/64                         fe80::91a7:6a2e:81d:cadd%utun2          UcI                 utun2       
# fe80::91a7:6a2e:81d:cadd%utun2          link#22                                 UHLI                  lo0       
# fe80::%utun3/64                         fe80::ce81:b1c:bd2c:69e%utun3           UcI                 utun3       
# fe80::ce81:b1c:bd2c:69e%utun3           link#23                                 UHLI                  lo0       
# fe80::%bridge100/64                     link#25                                 UCI             bridge100       
# fe80::5054:ff:fe4a:22af%bridge100       52.54.0.4a.22.af                        UHLWIi          bridge100       
# fe80::bcd0:74ff:fe35:b364%bridge100     be.d0.74.35.b3.64                       UHLI                  lo0       
# fe80::%utun4/64                         fe80::a0e5:11d1:a42d:52ad%utun4         UcI                 utun4       
# fe80::a0e5:11d1:a42d:52ad%utun4         link#26                                 UHLI                  lo0       
# fe80::%utun5/64                         fe80::a3b7:ad48:6ea5:d264%utun5         UcI                 utun5       
# fe80::a3b7:ad48:6ea5:d264%utun5         link#28                                 UHLI                  lo0       
# ff00::/8                                ::1                                     UmCI                  lo0       
# ff00::/8                                link#16                                 UmCI                  en0       
# ff00::/8                                link#18                                 UmCI                awdl0       
# ff00::/8                                link#19                                 UmCI                 llw0       
# ff00::/8                                fe80::d5:1cf3:555a:a53%utun0            UmCI                utun0       
# ff00::/8                                fe80::6411:ee8f:ffc6:dbfa%utun1         UmCI                utun1       
# ff00::/8                                fe80::91a7:6a2e:81d:cadd%utun2          UmCI                utun2       
# ff00::/8                                fe80::ce81:b1c:bd2c:69e%utun3           UmCI                utun3       
# ff00::/8                                link#25                                 UmCI            bridge100       
# ff00::/8                                fe80::a0e5:11d1:a42d:52ad%utun4         UmCI                utun4       
# ff00::/8                                fe80::a3b7:ad48:6ea5:d264%utun5         UmCI                utun5       
# ff01::%lo0/32                           ::1                                     UmCI                  lo0       
# ff01::%en0/32                           link#16                                 UmCI                  en0       
# ff01::%utun0/32                         fe80::d5:1cf3:555a:a53%utun0            UmCI                utun0       
# ff01::%utun1/32                         fe80::6411:ee8f:ffc6:dbfa%utun1         UmCI                utun1       
# ff01::%utun2/32                         fe80::91a7:6a2e:81d:cadd%utun2          UmCI                utun2       
# ff01::%utun3/32                         fe80::ce81:b1c:bd2c:69e%utun3           UmCI                utun3       
# ff01::%bridge100/32                     link#25                                 UmCI            bridge100       
# ff01::%utun4/32                         fe80::a0e5:11d1:a42d:52ad%utun4         UmCI                utun4       
# ff01::%utun5/32                         fe80::a3b7:ad48:6ea5:d264%utun5         UmCI                utun5       
# ff02::%lo0/32                           ::1                                     UmCI                  lo0       
# ff02::%en0/32                           link#16                                 UmCI                  en0       
# ff02::%utun0/32                         fe80::d5:1cf3:555a:a53%utun0            UmCI                utun0       
# ff02::%utun1/32                         fe80::6411:ee8f:ffc6:dbfa%utun1         UmCI                utun1       
# ff02::%utun2/32                         fe80::91a7:6a2e:81d:cadd%utun2          UmCI                utun2       
# ff02::%utun3/32                         fe80::ce81:b1c:bd2c:69e%utun3           UmCI                utun3       
# ff02::%bridge100/32                     link#25                                 UmCI            bridge100       
# ff02::%utun4/32                         fe80::a0e5:11d1:a42d:52ad%utun4         UmCI                utun4       
# ff02::%utun5/32                         fe80::a3b7:ad48:6ea5:d264%utun5         UmCI                utun5       


# view info on all sockets
netstat -at

# network info for ipv6
netstat -lt

```