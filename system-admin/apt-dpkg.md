# apt, dpkg

### Usage 1

```bash
echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ wheezy main" | sudo tee /etc/apt/sources.list.d/azure-cli.list
sudo apt-key adv --keyserver packages.microsoft.com --recv-keys 417A0893
```

### Usage 2

```bash
sudo add-apt-repository ppa:jonathonf/vim
sudo add-apt-repository ppa:webupd8team/java
```


