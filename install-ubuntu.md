# Setting up Ubuntu 16.04 on Digital Ocean

### Automatically spin up an Ubuntu droplet (using doctl)
`doctl compute droplet create <play-machine> --image ubuntu-16-04-x64 --size 512mb --region nyc3 --ssh-keys ...`

### Create a temporary SSH config
```bash
Host x
    Hostname <IP address> OR <x.indrayam.com>
    Port 22
    User root
```
### Update, upgrade and get basic software for compiling from source
```bash
sudo apt update
sudo apt upgrade
sudo add-apt-repository universe (Most likely the command will come back with...'universe' distribution component is already enabled for all sources.)
sudo unattended-upgrades (to install upgrades that might have been held back)
OPTIONAL: sudo apt list --upgradable
sudo apt install build-essential autoconf libcurl4-gnutls-dev libexpat1-dev gettext libz-dev libssl-dev zsh curl wget vim
```
### Add a user
```bash
adduser anand (It will prompt for all the entries in /etc/passwd) 
OR
useradd -c "Anand Sharma" -d "/home/anand" -s /bin/zsh anand
```
### Add user to sudo
```bash
su (if not already)
cd /etc
chmod 640 sudoers
Open sudoers and add the following entry:
<userid>    ALL=(ALL:ALL) NOPASSWD:ALL
chmod 440 sudoers
```
### SSH login using RSA authentication
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
Restart the SSHD daemon

```bash
ps aux|grep -i sshd
sudo service sshd restart
ps aux|grep -i sshd
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
sudo add-apt-repository ppa:jonathonf/vim
sudo apt update
sudo apt install vim
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
VERSION=2.6
sudo apt -y remove tmux
sudo apt -y install wget tar libevent-dev libncurses-dev
wget https://github.com/tmux/tmux/releases/download/${VERSION}/tmux-${VERSION}.tar.gz
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
sudo apt install gnupg2 
Make S3 object public using AWS Console
Copy dotgnupg.tar.gz from backup to ~/.gnupg:
cd ~/src
curl -v https://s3.amazonaws.com/us-east-1-anand-files/misc-files/dotgnupg.tar.gz
tar -xvzf dotgnupg.tar.gz
mv ~/.gnupg ~/.gnupg.bk
mv dotgnupg ~/.gnupg
```

### Install Java
[Source](https://www.digitalocean.com/community/tutorials/how-to-install-java-with-apt-get-on-ubuntu-16-04)

```bash
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install oracle-java8-installer
sudo apt-get install oracle-java9-installer
# Run the following command to get a sense of where JDK 8 (or 9) got installed. Create a symlink from /usr/local/java to wherever JDK 8 (or 9) was installed
sudo update-alternatives --config java
```

###  Install Maven

```bash
cd /usr/local/src
curl -O http://www-us.apache.org/dist/maven/maven-3/3.5.0/binaries/apache-maven-3.5.0-bin.tar.gz
tar -xvzf <file-name>.tar.gz
mv <folder-name> /usr/local/maven
mvn --version
```

###  Install Gradle

```bash
cd /usr/local/src
curl -O -L "https://services.gradle.org/distributions/gradle-4.2.1-bin.zip"
unzip <file-name>.zip
mv gradle-4.2.1 /usr/local/gradle
gradle --version
```

###  Install Groovy

```bash
cd /usr/local/src
curl -O -L "https://dl.bintray.com/groovy/maven/apache-groovy-binary-2.4.12.zip";
unzip <file-name>.zip
mv <folder-name> /usr/local/groovy
```

### Install Kotlinc

```bash
cd /usr/local/src
curl -O -L "https://github.com/JetBrains/kotlin/releases/download/v1.1.51/kotlin-compiler-1.1.51.zip"
unzip <file-name>.zip
mv <folder-name> /usr/local/kotlinc
```

### Install Go
[Source](https://github.com/udhos/update-golang)

```bash
git clone https://github.com/udhos/update-golang
cd update-golang
sudo RELEASE=1.9.1 ./update-golang.sh
Update ~/.zshrc and add /usr/local/go/bin in $PATH (if not already done)
```

### Install Python

```bash
curl -O https://www.python.org/ftp/python/3.6.3/Python-3.6.3.tgz
tar -xvzf Python-3.6.3.tgz
cd Python-3.6.3
./configure --prefix=/usr/local
make
sudo make install
cd /usr/local/bin
ln -s ./python3.6 python3
sudo pip3 install Flask colorama paramiko parsedatetime parsimonious psutil pylint pytest prompt-toolkit requests numpy scipy pymongo
```

### Install Node

```bash
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt-get install -y nodejs

# Building Practical Node Apps
#!/bin/bash
mkdir -p ~/workspace/node-apps/helloapp
cd ~/workspace/node-apps/helloapp
npm init
# Packge, Dependency Managers
sudo npm install -g yarn
sudo npm install -g npm
# Compiler
sudo npm install -g typescript
npm install babel-cli --save-dev
# Static Analysis
sudo npm install -g jshint
# Testing frameworks
sudo npm install -g mocha
sudo npm install -g jest
sudo npm install -g jasmine
# Module Bundler
sudo npm install -g webpack
sudo npm install -g browserify
# Execute <command> either from local node_modules/.bin or from a central cache
sudo npm install -g npx
# Command-line tool to create Angular client-side app
sudo npm install --unsafe-perm -g @angular/cli
# Command-line tool to create React client-side app
sudo npm install -g create-react-app
npm install react react-dom --save
# Command-line tool to create Vue.js client-side app
sudo npm install -g vue-cli
npm install vue --save
# Web App Framework (and related ecosystem)
npm install express --save
sudo npm install -g express-generator
npm install express-session --save
npm install cookie-parser --save
npm install errorhandler --save
npm install body-parser --save
npm install superagent --save
# Rich Framework for building applications and services
npm install hapi --save
# Logger
npm install morgan --save
# Templates
npm install pug --save
npm install handlebars --save
# Date/Time
npm install luxon --save 
# Command line
npm install commander --save 
npm install minimist --save
# Integrate with MongoDB
npm install mongodb --save
npm install mongoskin --save
npm install --save-dev babel-cli babel-preset-env
echo "Done!"
npm ls -g --depth=0
npm ls --depth=0
```

### Install Ruby

```bash
cd /usr/local/src
wget http://ftp.ruby-lang.org/pub/ruby/2.4/ruby-2.4.2.tar.gz
tar -xzvf ruby-2.4.2.tar.gz
cd ruby-2.4.2/
./configure --prefix=/usr
make
sudo make install
ruby -v
gem -v
sudo gem install bundler
sudo gem install rails sinatra
```

### Install Silver Searcher (Ag)

```bash
sudo apt-get install pkg-config libpcre3 libpcre3-dev liblzma-dev clang-format
curl -O https://geoff.greer.fm/ag/releases/the_silver_searcher-2.1.0.tar.gz
cd the_silver_searcher-2.1.0
./configure --prefix=/usr
make
sudo make install
```

### Install jq

```bash
sudo apt-get install jq
```

### Install httpie

```bash
sudo apt-get install httpie
```

### Install diff-so-fancy

```bash
cd /usr/local/bin
sudo curl -O https://raw.githubusercontent.com/so-fancy/diff-so-fancy/master/third_party/build_fatpack/diff-so-fancy
sudo chmod 755 diff-so-fancy
```

# Cloud Native Apps on Public Clouds

### Install Docker
[Source](https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/#install-using-the-repository)

```bash
sudo apt update
# Install these to make sure apt can install packages over HTTPS
sudo apt-get install apt-transport-https ca-certificates curl software-properties-common
# Add Docker’s official GPG key:
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
# Verify
sudo apt-key fingerprint 0EBFCD88
# Setup stable Docker APT repository
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-cache madison docker-ce
# Source: What is apt-cache madison? Source: https://askubuntu.com/questions/447/how-can-i-see-all-versions-of-a-package-that-are-available-in-the-archive

# Install a specific version
sudo apt-get install docker-ce=17.09.0~ce-0~ubuntu
OR
# Install the latest
sudo apt-get install docker-ce
sudo apt-get install docker-compose
# Test version
 sudo docker version
# Hello World
sudo docker run hello-world
# If you want to remove use of “sudo” to run docker commands, just add your Unix user to the group “docker”, assuming it exists
sudo usermod -aG docker <userid>
```

### Install Digital Ocean CLI (doctl)

```bash
cd ~/src
curl -L https://github.com/digitalocean/doctl/releases/download/v1.7.1/doctl-1.7.1-linux-amd64.tar.gz  | tar xz
sudo mv doctl /usr/local/bin
doctl auth init
doctl account get
```

### Install AWS and ECS CLI

```bash
sudo pip3 install awscli —upgrade
aws --version
# To get authenticated, you will need AWS Key ID and Secret Key:
aws configure
sudo curl -o /usr/local/bin/ecs-cli https://s3.amazonaws.com/amazon-ecs-cli/ecs-cli-linux-amd64-latest
echo "$(curl -s https://s3.amazonaws.com/amazon-ecs-cli/ecs-cli-linux-amd64-latest.md5) /usr/local/bin/ecs-cli" | md5sum -c -
sudo chmod 755 /usr/local/bin/ecs-cli
ecs-cli --version
ecs-cli configure profile --profile-name sez --access-key <enter-key> --secret-key <enter-description>
ecs-cli configure profile default --profile-name sez
```

### Install Google Cloud CLI

**Approach 1 (Preferred)**

```bash
cd src/
curl https://sdk.cloud.google.com | sudo bash
```

**Approach 2**
Note: Experienced issues when I ran sudo apt-get update

```bash
# Create an environment variable for the correct distribution
export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)"

# Add the Cloud SDK distribution URI as a package source
echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list

# Import the Google Cloud Platform public key
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

# Update the package list and install the Cloud SDK
sudo apt-get update && sudo apt-get install google-cloud-sdk

# Check version
gcloud --version

# To get authenticated
gloud init
OR
gcloud init --console-only

# Note: I had to run these steps as the gcloud-sdk step kept failing
sudo dd if=/dev/zero of=/var/swap bs=1024 count=524288
sudo chmod 600 /var/swap
sudo mkswap /var/swap
sudo swapon /var/swap
sudo apt upgrade
```

### Install Microsoft Azure CLI

```bash
echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ wheezy main" | sudo tee /etc/apt/sources.list.d/azure-cli.list
sudo apt-key adv --keyserver packages.microsoft.com --recv-keys 417A0893
sudo apt-get install apt-transport-https
sudo apt-get update && sudo apt-get install azure-cli
az login
```

It responded by spitting this on the terminal

```json
[
  {
    "cloudName": "AzureCloud",
    "id": "....",
    "isDefault": true,
    "name": "Pay-As-You-Go",
    "state": "Enabled",
    "tenantId": "....",
    "user": {
      "name": "anand.sharma@gmail.com",
      "type": "user"
    }
  }
]
```

### Install Helm
[Source 1](https://github.com/kubernetes/helm/releases)
[Source 2](https://docs.helm.sh/using_helm/#installing-helm)

```bash
cd /usr/local/src
curl -O https://storage.googleapis.com/kubernetes-helm/helm-v2.7.0-linux-amd64.tar.gz
tar -xvzf helm-v2.7.0-linux-amd64.tar.gz
cd linux-amd64
sudo mv helm /usr/local/bin
helm version
```

### Install Ansible

```bash
sudo apt-add-repository ppa:ansible/ansible
sudo apt-get update
sudo apt-get install ansible
```

### Install terraform

```bash
sudo apt-get install zip
cd /usr/local/src
curl -O -L https://releases.hashicorp.com/terraform/0.10.7/terraform_0.10.7_linux_amd64.zip
unzip terraform_0.10.7_linux_amd64.zip
sudo mv terraform /usr/local/bin
terraform —version
```

# Configure a new DO Droplet created from a snapshot (Ubuntu)
- Create a new [DigitalOcean](http://digitalocean.com) Droplet using the pre-existing snapshot
- After the Droplet has launched, access it using the "Console"
- Confirm that eth0 did not come up by running the following command. It should show an error message

```bash
sudo systemctl status networking.service
```
- Run `ip route` command to confirm the same
- Also, running `ifconfig -a` will show that eth0 never really came up. Instead, `ens3` is the network interface that was created. `dmesg | grep -i eth0` will show this name change event too
- Let's fix the Droplet name by editing the entries inside /etc/hosts and /etc/hostname files to reflect the new name that was selected during Droplet creation
- Let's fix the eth0 interface configuration. The reason why it did not come up was because the snapshot unfortunately preserves the IP address, Mac address, Hostname etc. configurations of the original Droplet that was used to create the snapshot. 
- Run `ifconfig -a` and copy the HW address for the `ens3` network interface
- Edit `/etc/network/interfaces.d/50-cloud-init.cfg` file's eth0 entries by updating the Public IP and Gateway entries to match the values for the new Droplet. The "Networking" section of the Digital Ocean console will tell you the Public IP and Gateway IP details for the new Droplet. Also, the DO Console tells that too at the bottom of the Console window
- Edit `/etc/udev/rules.d/70-persistent-net.rules` file by changing the `ATTR{address}` (for the line where `NAME="eth0"`) to reflect the HW address that was copied a few steps ago by running the `ifconfig -a` command: 

```bash
SUBSYSTEM=="net", ACTION=="add", DRIVERS=="?*", ATTR{address}=="06:8a:13:ad:46:00", NAME="eth0"
```
- Reboot and Log in to the console. Run the steps above to make sure that the `eth0` networking interface is up and running!
- Run `ip a show eth0` to confirm that the ip address is mapped correctly to the eth0 interface

**References:**
- [Failed to bring up eth0](https://www.digitalocean.com/community/questions/failed-to-bring-up-eth0)
- [Problem with updating Kernel (eth0 now missing)](https://www.digitalocean.com/community/questions/problem-with-updating-kernel-eth0-now-missing)
- [Ubuntu Network Configuration](https://help.ubuntu.com/lts/serverguide/network-configuration.html)
