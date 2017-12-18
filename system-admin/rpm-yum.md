# rpm, yum

### Usage 1

```bash
# Import the Microsoft Key
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[azure-cli]\nname=Azure CLI\nbaseurl=https://packages.microsoft.com/yumrepos/azure-cli\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/azure-cli.repo'
```

### Usage 2

```bash
yum list docker-ce --showduplicates | sort -r
```

### Usage 3

```bash
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
```

### Usage 4

```bash
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
```

### Usage 5

```bash
yum check-update
```


