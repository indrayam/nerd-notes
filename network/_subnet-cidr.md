# subnet/cidr 

Class A address: First octet is between 1 and 127 (binary address begins with 0)
Class B address: First octet is between 128 and 191 (binary address begins with 10)
Class B address: First octet is between 192 and 223 (binary address begins with 110)

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
11000000.10101000.00001001.00000000 = 192.168.10.0
    First IP of the subnet  = 192.168.10.0
    Host address range      = 192.168.10.1 to 192.168.10.6
    Last IP of the subnet   = 192.168.10.7
11000000.10101000.00001001.00001000 = 192.168.10.8
11000000.10101000.00001001.00011000 = 192.168.10.24
11000000.10101000.00001001.00101000 = 192.168.10.40
...
...
11000000.10101000.00001001.11111000 = 192.168.10.248
```

**Note:**
1. For a given CIDR (/29), I calculate the number of subnets by raising 2 to the power of the number of host bits in an IP octet that are reserved for the subnet. So, **/29** means 5 host bits are reserved for subnetting. **2^5 = 32!**
2. For a given CIDR(/29), I calculate the number of IP Hosts by raising 2 to the power of the **32 - CIDR number**. In **/29**, **32 - 29 (3)** bits are reserved for IP hosts. That makes it **2^3** IP hosts. But since 2 IPs need to be reserved for the subnet and the broadcast address, it means 6 IP hosts can be assigned per subnet

### CIDR (Classless Internet Domain Routing)

CIDR (Classless Inter-Domain Routing, sometimes called supernetting) is a way to allow more flexible allocation of Internet Protocol (IP) addresses than was possible with the original system of IP address classes.

So, subnet mask 255.255.255.224 will be represented using the CIDR prefix of **/27**

For more, read [Understanding CIDR Subnet Mask Notation](https://doc.m0n0.ch/quickstartpc/intro-CIDR.html)


