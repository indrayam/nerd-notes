# apt, dpkg

### Usage 1

```bash
echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ wheezy main" | sudo tee /etc/apt/sources.list.d/azure-cli.list
sudo apt-key adv --keyserver packages.microsoft.com --recv-keys 417A0893
```

Fix apt-get update "..the following signatures couldn’t be verified because the public key is not available.." [Source](https://chrisjean.com/fix-apt-get-update-the-following-signatures-couldnt-be-verified-because-the-public-key-is-not-available/)

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
Source: [http://www.cyberciti.biz/tips/linux-debian-package-management-cheat-sheet.html](http://www.cyberciti.biz/tips/linux-debian-package-management-cheat-sheet.html)

```bash
dpkg -i <deb-file-name>
dpkg -L <deb-package-name> #to list the contents
dpkg -s <package-name>
dpkg -S <file-name> # to list the name of the package from which this file came
```

### Usage 6

Remove from terminal if you know the ppa:

`sudo add-apt-repository -r ppa:<ppa to remove>`

Or, edit the `/etc/apt/sources.list` to find your ppa there, and remove from there manually (or automatically). Or, remove the ppa file from `/etc/apt/sources.list.d` in newer versions of Ubuntu.
```



