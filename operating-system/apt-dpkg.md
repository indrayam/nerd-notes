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
sudo apt-add-repository ppa:ansible/ansible
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
```

### Usage 3

```bash
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
```

### Usage 4
[Source: What is apt-cache madison?](https://askubuntu.com/questions/447/how-can-i-see-all-versions-of-a-package-that-are-available-in-the-archive)

```bash
apt-cache madison docker-ce
```

### Usage 5 (dpkg)

```bash
dpkg -i <deb-file-name>
dpkg -L <deb-package-name> (to list the contents)
http://www.cyberciti.biz/tips/linux-debian-package-management-cheat-sheet.html 
```




