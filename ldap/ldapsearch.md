### ldap client

### Install ldap-utils on Ubuntu 16.04 using the following command:

```bash
sudo apt-get install ldap-utils
```

### User Search

[Reference](https://stackoverflow.com/questions/22224465/querying-windows-active-directory-server-using-ldapsearch-from-command-line)

```bash
ldapsearch -LLL -H ldap://ds.cisco.com:389 -b "OU=Employees,OU=Cisco Users, DC=cisco, DC=com" -D 'dft-ds.gen@cisco.com' -w '' '(cn=visardan,ou=Employees,ou=Cisco Users,dc=cisco,dc=com)'

# Search Users
ldapsearch -LLL -H ldap://ds.cisco.com:389 -b "OU=Employees,OU=Cisco Users, DC=cisco, DC=com" -D 'CN=cd-spinnaker.gen,OU=Generics,OU=Cisco Users,DC=cisco,DC=com' -w '<password>' '(sAMAccountName=visardan)'

# Search over SSL (see notes below). Search for Users and Generics
ldapsearch -LLL -H ldaps://ds.cisco.com:636 -b "OU=Employees,OU=Cisco Users, DC=cisco, DC=com" -D 'CN=cd-spinnaker.gen,OU=Generics,OU=Cisco Users,DC=cisco,DC=com' -w '<password>' '(sAMAccountName=visardan)'

# Search for a CEC or Generic User
ldapsearch -LLL -H ldap://ds.cisco.com:389 -b "DC=cisco, DC=com" -D 'dft-ds.gen@cisco.com' -w '<password>' '(&(objectClass=user)(|(distinguishedName=CN='visardan', OU=Generics, OU=Cisco Users, DC=cisco, DC=com)(distinguishedName=CN='visardan', OU=Employees, OU=Cisco Users, DC=cisco, DC=com)))'

# Return pre-selected list of attributes
ldapsearch -LLL -H ldaps://ds.cisco.com:636 -b "OU=Employees,OU=Cisco Users, DC=cisco, DC=com" -D 'CN=cd-spinnaker.gen,OU=Generics,OU=Cisco Users,DC=cisco,DC=com' -w '<password>' '(sAMAccountName=visardan)' cn mail

ldapsearch -LLL -H ldaps://ds.cisco.com:636 -b "OU=Employees,OU=Cisco Users, DC=cisco, DC=com" -D 'dft-ds.gen@cisco.com' -w '' '(cn=visardan)' cn mail
```

If you are using LDAPS, create a ldaprc file in the same directory where you are running the command with this content:

```bash
HOST ds.cisco.com
PORT 636
TLS_REQCERT ALLOW
```

### Group Search

```bash
# Search for all the Groups to which the User Belongs
ldapsearch -LLL -H ldaps://ds.cisco.com:636 -b "OU=Standard,OU=Cisco Groups, DC=cisco, DC=com" -D 'dft-ds.gen@cisco.com' -w '' '(member=CN=anasharm,OU=Employees,OU=Cisco Users,DC=cisco,DC=com)'
```

### Configure ActiveDirectory settings

```bash
CN=dft-ds.gen,OU=Generics,OU=Cisco Users,DC=cisco,DC=com
Domain Controller: ds.cisco.com:3268
Domain Name: cisco.com
```

