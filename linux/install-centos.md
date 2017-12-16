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

### Install latest tmux
[Source](https://gist.github.com/indrayam/ebf53ba970241694865e1dd2b1313945)

```bash
# Steps to build and install tmux from source on Ubuntu.
# Takes < 25 seconds on EC2 env [even on a low-end config instance].
cd ~/src
sudo yum install libevent-devel ncurses-devel
VERSION=2.6
wget "https://github.com/tmux/tmux/releases/download/${VERSION}/tmux-${VERSION}.tar.gz"
tar xf tmux-${VERSION}.tar.gz
cd tmux-${VERSION}
./configure
make
sudo make install
# Logout and login to the shell again and run.
tmux -V
```

### Install GPG2

```bash
sudo yum install gnupg2 # However, the version was already installed and it was 2.0.22 
# Installing gnupg depencies first from source
curl -L -O https://www.gnupg.org/ftp/gcrypt/libgpg-error/libgpg-error-1.27.tar.bz2
tar -xvjf libgpg-error-1.27.tar.gz2
cd libgpg-error-1.27
./configure --prefix=/usr/local
make
sudo make install

curl -L -O https://www.gnupg.org/ftp/gcrypt/libgcrypt/libgcrypt-1.8.2.tar.bz2
tar -xvjf libgcrypt-1.8.2.tar.bz2
cd libgcrypt-1.8.2
./configure --prefix=/usr/local
make
sudo make install

curl -L -O https://www.gnupg.org/ftp/gcrypt/libksba/libksba-1.3.5.tar.bz2
tar -xvjf libksba-1.3.5.tar.bz2
cd libksba-1.3.5
./configure --prefix=/usr/local
make
sudo make install


curl -L -O https://www.gnupg.org/ftp/gcrypt/libassuan/libassuan-2.5.1.tar.bz2
tar -xvjf libassuan-2.5.1.tar.bz2
cd libassuan-2.5.1
./configure --prefix=/usr/local
make
sudo make install

curl -L -O https://www.gnupg.org/ftp/gcrypt/ntbtls/ntbtls-0.1.2.tar.bz2
tar -xvjf ntbtls-0.1.2.tar.bz
cd ntbtls-0.1.2
./configure --prefix=/usr/local
make
sudo make install

curl -L -O https://www.gnupg.org/ftp/gcrypt/npth/npth-1.5.tar.bz2
tar -xvjf npth-1.5.tar.bz2
cd npth-1.5
./configure --prefix=/usr/local
make
sudo make install

# Make sure that /usr/local/lib is added to /etc/ld.so.conf.d/ folder
sudo echo "/usr/local/lib" > /etc/ld.so.conf.d/gnupg2-x86_64.conf
sudo rm /etc/ld.so.cache
sudo ldconfig

# Installing gnupg depencies first from source
curl -L -O https://www.gnupg.org/ftp/gcrypt/gnupg/gnupg-2.2.3.tar.bz2
tar -xvjf gnupg-2.2.3.tar.bz2
cd gnupg-2.2.3
./configure --prefix=/usr/local
make
sudo make install
# Make S3 object (https://s3.console.aws.amazon.com/s3/object/us-east-1-anand-files/misc-files/dotgnupg.tar.gz?region=us-east-1&tab=overview) public using AWS Console
cd ~/src
curl -O https://s3.amazonaws.com/us-east-1-anand-files/misc-files/dotgnupg.tar.gz
tar -xvzf dotgnupg.tar.gz
mv ~/.gnupg ~/.gnupg.bk
mv dotgnupg ~/.gnupg
# Check if the key got setup correctly
gpg --list-keys --keyid-format LONG
```
