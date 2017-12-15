# Setting up Ubuntu 16.04 on Digital Ocean

### Automatically spin up an Ubuntu droplet (using doctl)
```bash
# Get the SSH key stored with DO
doctl compute ssh-key list
doctl compute droplet create shannon-machine --image centos-7-x64 --size 1gb --region nyc3 --ssh-keys <ssh-key>
```

### Create a temporary SSH config

```bash
Host c
    Hostname <IP address> OR <c.indrayam.com>
    Port 22
    User root
    IdentityFile ~/.ssh/id_rsa
```

### Update, upgrade and get basic software for compiling from source
```bash
yum update
yum upgrade
yum install wget
wget http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
rpm -ivh epel-release-latest-7.noarch.rpm
yum repolist
# To get info or install a repo specifically from EPEL repo, use commands like the following
# yum --enablerepo=epel info curl
# yum --enablerepo=epel install curl
yum groupinstall "Development tools"
yum install vim patch zsh curl-devel expat-devel openssl-devel zlib-devel readline-devel sqlite-devel libxml2-devel libxslt libxslt-devel libtool-ltdl-devel bzip2-devel pcre-devel httpd-devel tree jq ncurses-devel perl-CPAN bind-utils libffi-devel
```
### Add a user
```bash
adduser anand (It will prompt for all the entries in /etc/passwd) 
OR
useradd -c "Anand Sharma" -d "/home/anand" -s /bin/zsh anand
```

### Add user to sudo
```bash
cd /etc
chmod 640 sudoers
Open sudoers and add the following entry:
<userid>    ALL=(ALL:ALL) NOPASSWD:ALL
chmod 440 sudoers
```

### SSH login using RSA authentication
SSH daemon, by default, does not allow Password based authentication. So, first, open `/etc/ssh/sshd_config` and edit this line:

```bash
PasswordAuthentication yes # Default value is "no"
```

Restart SSH server using the command `sudo systemctl restart sshd.service` (or `sudo service sshd restart`). Btw, if you want to know all services defined by `systemd`, check out `/etc/systemd/system/` folder. I ran the `tree .` command to get all the entries. Reset it after everything looks good with SSH access.

```bash
Update ~/.ssh/config with the following changes:
Host x
    Hostname <IP address> OR <x.indrayam.com>
    Port 22
    User anand
    IdentityFile ~/.ssh/id_rsa
cat .ssh/id_rsa.pub | ssh x "cat >> ~/.ssh/authorized_keys"
```

In client SSH `~/.ssh/config`:

```bash
Host *
   ServerAliveInterval 100
   ServerAliveCountMax 100
In server SSHD /etc/ssh/sshd_config
ClientAliveInterval 60¬
ClientAliveCountMax 10000
```

Copy the SSH keys from Digital Ocean accounts (or Dropbox) to the new server.

### Get /usr/local/src ready to install a few softwares

Login as `anand`

```bash
sudo chown -R anand.anand /usr/local/src
ln -s /usr/local/src src
```

### Install latest Git

```bash
cd ~/src
curl -L -O https://github.com/git/git/archive/v2.15.1.tar.gz
tar -xvzf git*tar.gz
cd <git-foler>
make configure
./configure --prefix=/usr/local
make all
sudo make install
```

### Install latest Vim

```bash
curl -L -O https://github.com/vim/vim/archive/v8.0.1391.tar.gz
tar -xvzf v8.0.<tab>
cd vim-<tab>
./configure
make
sudo make install
```

### Install oh-my-zsh and dotfiles.git repo from GitHub

```bash
ssh -T git@github.com #Check to make sure you can clone repos from Git
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
git clone git@github.com:indrayam/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./setup-symlinks-linux.sh
exit
ssh x
# Install Vundle by running the following command:
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim
:PluginInstall
```
