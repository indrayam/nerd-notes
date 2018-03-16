# subnet/cidr 

### Classful IP Addresses

Class A address: First octet is between 1 and 127 (binary address begins with 0, Default subnet mask: 255.0.0.0, CIDR notation: /8)
Class B address: First octet is between 128 and 191 (binary address begins with 10, Default subnet mask: 255.255.0.0, CIDR notation: /16)
Class C address: First octet is between 192 and 223 (binary address begins with 110, Default subnet mask: 255.255.255.0, CIDR notation: /24)

### CIDR (Classless Internet Domain Routing)

CIDR (Classless Inter-Domain Routing, sometimes called supernetting) is a way to allow more flexible allocation of Internet Protocol (IP) addresses than was possible with the original system of IP address classes.

So, subnet mask 255.255.255.224 will be represented using the CIDR prefix of **/27**

### Subnet Calculations using Class C address

* [Simplify Routing with Subnetting: How to Organize Your Network Into Smaller Subnets](https://www.pluralsight.com/blog/it-ops/simplify-routing-how-to-organize-your-network-into-smaller-subnets)
* [Online calculator](http://www.subnet-calculator.com/)

For IP address **192.168.10.44** with subnet mask **255.255.255.248**, what's the subnet address and how many hosts are there in that subnet?

```
255.255.255.248 => /8 + 8 + 8 + 5 => /29
192.168.10.44   = 11000000.10101000.00001001.00101100
255.255.255.248 = 11111111.11111111.11111111.11111000
                ======================================
                  11000000.10101000.00001001.00101000 ==> 192.168.10.40
```

**Answer:**

The subnet address is **192.168.10.40**. This subnet address has **2^3 - 2** (6) hosts per subnet. How many subnets are there? **2^5 = 32**. 

What are these subnets (Subnet ID)?

```
First Subnet:
11000000.10101000.00001001.00000000 = 192.168.10.0
    First IP of the subnet  = 192.168.10.0
    Host address range      = 192.168.10.1 to 192.168.10.6
    Last IP of the subnet   = 192.168.10.7
Second Subnet:
192.168.10.8
192.168.10.16
192.168.10.24
192.168.10.32
192.168.10.40
...
...
11000000.10101000.00001001.11111000 = 192.168.10.248
```

### How to calculate # of Subnets/Hosts given an IP address and Subnet Mask

**Explanation 1:**

1. For a given CIDR (/29) and an IP address, first figure out what class does the IP address belong to. 192.168.10.140 is a Class C address with a default subnet mask of /24. Since in this case, the subnet mask is /29, 5 extra "host" bits are being used for creating subnets. So, to calculate the number of subnets, raise 2 to the power of the number of host bits that are reserved for the subnet. So, **/29** means 5 host bits are reserved for subnetting. **2^5 = 32!**

Default classes matter in number of subnetting bits. So, if the IP address was 172.168.5.139 and the subnet mask was 255.255.255.248 (/29), since the default subnet mask of a Class B address is /16, **29 - 16 = 13** extra "host" bits are being used for creating subnets. So, to calculate the number of subnets, raise 2 to the power of 13 (or **8192**) subnets would be possible. In subnetting do not touch default mask bits; 8 for Class A; 16 for class B; 24 for Class C. The number of hosts within the subnet would still be **2^5** or 32, same as for a Class C IP address!

2. For a given CIDR (/29), I calculate the number of IP Hosts by raising 2 to the power of the **32 - CIDR number**. In **/29**, **32 - 29 (3)** bits are reserved for IP hosts. That makes it **2^3** IP hosts. But since 2 IPs need to be reserved for the subnet and the broadcast address, it means 6 IP hosts can be assigned per subnet

**Explanation 2:**

Your 32 bit IP address will consist of "n" network bits set by the class the IP address belongs to, "s" additional network bits based on the actual mask given to you, and "h" bits which are everything else leftover.

So, for an IP address 192.168.10.40, which is a class C address and a subnet mask of /29, you get:
- n = 24 (because it is a Class C address)
- s = 29 - 24 = 5 (extra host bits being used for creating subnets)
- h = 32 - 29 = 3 

So, total number of subnets = **2^5** = **32** (since s = 5) and total IP host addresses = **2^3** = 8 (since h = 3)

The key to getting the total number of subnets are those "s" bits.

### References
- [Understanding IP Addresses, Subnets, and CIDR Notation for Networking](https://www.digitalocean.com/community/tutorials/understanding-ip-addresses-subnets-and-cidr-notation-for-networking)
- [Understanding CIDR Subnet Mask Notation](https://doc.m0n0.ch/quickstartpc/intro-CIDR.html)
- [How to find the total number of subnets available for one subnet mask](https://learningnetwork.cisco.com/thread/21527)


