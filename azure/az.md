# az cli
```bash
For version info, use 'az --version'

Group
    az

Subgroups:
    account          : Manage Azure subscription information.
    acr              : Manage Azure Container Registries.
    acs              : Manage Azure Container Services.
    ad               : Synchronize on-premises directories and manage Azure Active Directory
                       resources.
    aks              : Manage Kubernetes clusters
...
```

### Getting help for a sub-command
For example: Here's how you get help for "configure" sub-command

```bash
az configure --help
```

### Log in to Azure

```bash
az login
```

### Show my current configuration

```bash
az configure
```

### Get version

```bash
az --version
```

### Get regions

```bash
az account list-locations | jq '.[] | "\(.displayName) \(.id)"'
```

### Work with VMs

```bash
az vm list
az vm list-ip-addresses
ssh azureuser@52.224.179.98
```
