### ldap client

Install ldap-utils on Ubuntu 16.04 using the following command:

```bash
sudo apt-get install ldap-utils
```

Use ldapsearch to search MS Active Directory

[Reference](https://stackoverflow.com/questions/22224465/querying-windows-active-directory-server-using-ldapsearch-from-command-line)

```bash
ldapsearch -LLL -H ldap://ds.cisco.com:3268 -b "OU=Employees,OU=Cisco Users, DC=cisco, DC=com" -D 'dft-ds.gen@cisco.com' -W '(sAMAccountName=anasharm)'

ldapsearch -LLL -H ldap://ds.cisco.com:389 -b "OU=Employees,OU=Cisco Users, DC=cisco, DC=com" -D 'dft-ds.gen@cisco.com' -w '<enter password' '(sAMAccountName=anasharm)'
```

Configure ActiveDirectory settings

```bash
CN=dft-ds.gen,OU=Generics,OU=Cisco Users,DC=cisco,DC=com
Domain Controller: ds.cisco.com:3268
Domain Name: cisco.com
```
