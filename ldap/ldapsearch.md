### ldap client

### Install ldap-utils on Ubuntu 16.04 using the following command:

```bash
sudo apt-get install ldap-utils
```

### User Search

[Reference 1](https://stackoverflow.com/questions/22224465/querying-windows-active-directory-server-using-ldapsearch-from-command-line)
[Reference 2](https://www.digitalocean.com/community/tutorials/how-to-manage-and-use-ldap-servers-with-openldap-utilities)

```bash
ldapsearch -LLL -H ldap://ds.cisco.com:389 -b "OU=Employees,OU=Cisco Users, DC=cisco, DC=com" -D 'dft-ds.gen@cisco.com' -w '' '(sAMAccountName=anasharm)'

# Search Users
ldapsearch -LLL -H ldap://ds.cisco.com:389 -b "OU=Employees,OU=Cisco Users, DC=cisco, DC=com" -D 'CN=cd-spinnaker.gen,OU=Generics,OU=Cisco Users,DC=cisco,DC=com' -w '<password>' '(sAMAccountName=visardan)'

# Search over SSL (see notes below). Search for Users and Generics
ldapsearch -LLL -H ldaps://ds.cisco.com:636 -b "OU=Employees,OU=Cisco Users, DC=cisco, DC=com" -D 'CN=cd-spinnaker.gen,OU=Generics,OU=Cisco Users,DC=cisco,DC=com' -w '<password>' '(sAMAccountName=visardan)'

# Search for a CEC or Generic User
ldapsearch -LLL -H ldap://ds.cisco.com:389 -b "DC=cisco, DC=com" -D 'dft-ds.gen@cisco.com' -w '<password>' '(&(objectClass=user)(|(distinguishedName=CN='visardan', OU=Generics, OU=Cisco Users, DC=cisco, DC=com)(distinguishedName=CN='visardan', OU=Employees, OU=Cisco Users, DC=cisco, DC=com)))'

# Search for a CEC or Generic User
ldapsearch -LLL -H ldap://ds.cisco.com:389 -b "DC=cisco, DC=com" -D 'dft-ds.gen@cisco.com' -w '' '(&(objectClass=user)(|(distinguishedName=CN='spinnaker-demo1.gen', OU=Generics, OU=Cisco Users, DC=cisco, DC=com)(distinguishedName=CN='spinnaker-demo1.gen', OU=Employees, OU=Cisco Users, DC=cisco, DC=com)))'

# Return pre-selected list of attributes
ldapsearch -LLL -H ldaps://ds.cisco.com:636 -b "OU=Employees,OU=Cisco Users, DC=cisco, DC=com" -D 'CN=cd-spinnaker.gen,OU=Generics,OU=Cisco Users,DC=cisco,DC=com' -w '<password>' '(sAMAccountName=visardan)' cn mail

# Search using cn
ldapsearch -LLL -H ldaps://ds.cisco.com:636 -b "OU=Employees,OU=Cisco Users, DC=cisco, DC=com" -D 'dft-ds.gen@cisco.com' -w '' '(cn=visardan)' cn mail

# Find all users under OU=Employees, OU=Cisco Users, DC=Cisco, DC=Com who are included in Group of Groups
ldapsearch -LLL -H ldap://ds.cisco.com:389 -b "OU=Employees, OU=Cisco Users, DC=cisco, DC=com" -D 'CN=cd-spinnaker.gen,OU=Generics,OU=Cisco Users,DC=cisco,DC=com' -w '<password>' '(&(objectClass=user)(memberof:1.2.840.113556.1.4.1941:=CN=dft-us-sdaas-users,OU=Standard,OU=Cisco Groups,DC=cisco,DC=com))' -z 1000 sAMAccountName

# Find all the details about a Group
ldapsearch -LLL -H ldaps://ds.cisco.com:636 -b "OU=Standard,OU=Cisco Groups, DC=cisco, DC=com" -D 'dft-ds.gen@cisco.com' -w '' '(cn=code-anasharm)'

ldapsearch -LLL -H ldaps://ds.cisco.com:636 -b "OU=Standard,OU=Cisco Groups, DC=cisco, DC=com" -D 'dft-ds.gen@cisco.com' -w '' '(cn=code-admin)'

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
ldapsearch -LLL -H ldaps://ds.cisco.com:636 -b "OU=Standard,OU=Cisco Groups, DC=cisco, DC=com" -D 'dft-ds.gen@cisco.com' -w '' '(member=CN=anasharm,OU=Employees,OU=Cisco Users,DC=cisco,DC=com)' cn

ldapsearch -LLL -H ldaps://ds.cisco.com:636 -b "OU=Standard,OU=Cisco Groups, DC=cisco, DC=com" -D 'dft-ds.gen@cisco.com' -w '' '(member=CN=jenkins-admin.gen,OU=Generics,OU=Cisco Users,DC=cisco,DC=com)' cn

ldapsearch -LLL -H ldaps://ds.cisco.com:636 -b "OU=Standard,OU=Cisco Groups, DC=cisco, DC=com" -D 'dft-ds.gen@cisco.com' -w '' '(member=CN=deepejai,OU=Employees,OU=Cisco Users,DC=cisco,DC=com)' cn

ldapsearch -LLL -H ldaps://ds.cisco.com:636 -b "OU=Standard,OU=Cisco Groups, DC=cisco, DC=com" -D 'dft-ds.gen@cisco.com' -w '' '(member=CN=sujmuthu,OU=Employees,OU=Cisco Users,DC=cisco,DC=com)' cn

ldapsearch -LLL -H ldaps://ds.cisco.com:636 -b "OU=Standard,OU=Cisco Groups, DC=cisco, DC=com" -D 'dft-ds.gen@cisco.com' -w '' '(member=CN=phwhitin,OU=Employees,OU=Cisco Users,DC=cisco,DC=com)' cn

ldapsearch -LLL -H ldaps://ds.cisco.com:636 -b "OU=Cisco Groups, DC=cisco, DC=com" -D 'dft-ds.gen@cisco.com' -w '' '(member=CN=jalagars,OU=Employees,OU=Cisco Users,DC=cisco,DC=com)' cn

ldapsearch -LLL -H ldaps://ds.cisco.com:636 -b "OU=Cisco Groups, DC=cisco, DC=com" -D 'dft-ds.gen@cisco.com' -w '' '(member=CN=cd-spinnaker.gen,OU=Generics,OU=Cisco Users,DC=cisco,DC=com)' cn
```

### Configure ActiveDirectory settings

```bash
CN=dft-ds.gen,OU=Generics,OU=Cisco Users,DC=cisco,DC=com
Domain Controller: ds.cisco.com:3268
Domain Name: cisco.com
```

### Useful Queries

```bash

# Show the groups already created/migrated to groups.cisco.com
ldapsearch -LLL -H ldaps://ds.cisco.com:636 -b "OU=Employees,OU=Cisco Users, DC=cisco, DC=com" -D 'CN=dft-ds.gen,OU=Generics,OU=Cisco Users,DC=cisco,DC=com' -w $DFT_PASSWORD '(sAMAccountName=anasharm)' | grep -v "OU=[Mailer|Standard|Grouper|Organizational]" | grep -i "OU=Cisco Groups,DC=cisco,DC=com"

```

### Work Notes


```
// Employees are all here...
--CN=anasharm
OU=Employees
OU=Cisco Users
DC=cisco
DC=com


// Standard Groups are all here...
--CN=dftcd-apps-admin
OU=Standard
OU=Cisco Groups
DC=cisco
DC=com


// Mailer Groups are all here...
--CN=code-leads
OU=Mailer
OU=Cisco Groups
DC=cisco
DC=com

// Groups created by groups.cisco.com are all here...
--CN=hello-code-admin
OU=Cisco Groups
DC=cisco
DC=com
```

```bash
# Cisco Employee
ldapsearch -v -LLL -b "OU=Employees,OU=Cisco Users, DC=cisco, DC=com" -D 'anasharm@cisco.com' -w $OS_PASSWORD '(cn=melvgo)'

# Generic Users
ldapsearch -v -LLL -b "OU=Generics,OU=Cisco Users, DC=cisco, DC=com" -D 'anasharm@cisco.com' -w $OS_PASSWORD '(cn=jenkins-ci.gen)'

# Standard Group
ldapsearch -LLL -b "OU=Standard,OU=Cisco Groups, DC=cisco, DC=com" -D 'anasharm@cisco.com' -w $OS_PASSWORD '(cn=sfdc-platform-services)'

# Mailer Group
ldapsearch -LLL -b "OU=Mailer,OU=Cisco Groups, DC=cisco, DC=com" -D 'anasharm@cisco.com' -w $OS_PASSWORD '(cn=cd-experience-dev)'

# Group created using Groups.cisco.com
ldapsearch -LLL -b "OU=Cisco Groups, DC=cisco, DC=com" -D 'anasharm@cisco.com' -w $OS_PASSWORD '(cn=hello-code-admin)'

# Find all the groups a user belongs to
ldapsearch -LLL -H ldaps://ds.cisco.com:636 -b "OU=Standard,OU=Cisco Groups, DC=cisco, DC=com" -D 'anasharm@cisco.com' -w $OS_PASSWORD '(member=CN=melvgo,OU=Employees,OU=Cisco Users,DC=cisco,DC=com)' cn
```