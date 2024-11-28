# Setting up Ubuntu 16.04

### Create a temporary SSH config in ~/.ssh/config

```
Host x
    Hostname <IP address> OR <x.indrayam.com>
    Port 22
    User root
```

### Update, upgrade and get basic software for compiling from source

```bash
sudo apt update
sudo apt upgrade
# Most likely the command will come back with...'universe' distribution component is already enabled for all sources.
sudo add-apt-repository universe 
# Install upgrades that might have been held back
sudo unattended-upgrades
# This is a command to check if which softwares that are ready for an upgrade
# sudo apt list --upgradable
sudo apt install build-essential autoconf libcurl4-gnutls-dev libexpat1-dev gettext zlib1g-dev libssl-dev zsh curl wget vim tar libevent-dev libncurses5-dev zip pkg-config libpcre3 libpcre3-dev liblzma-dev clang-format
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
curl -L -O https://github.com/git/git/archive/v2.18.0.tar.gz
tar -xvzf v2.18.0.tar.gz
cd git-2.18.0
make configure
./configure --prefix=/usr/local
make all
sudo make install

# Check version
git --version
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
cd
git clone git@github.com:indrayam/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./setup-symlinks-linux.sh
exit
ssh x
# Install Vundle by running the following command:
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

# Check installation
vim
```

### Install latest tmux
[Source](https://gist.github.com/indrayam/ebf53ba970241694865e1dd2b1313945)

```bash
# Steps to build and install tmux from source on Ubuntu.
# Takes < 25 seconds on EC2 env [even on a low-end config instance].
VERSION=2.6
sudo apt -y remove tmux
# If installing tmux in sequence, the next step is OPTIONAL
# sudo apt -y install wget tar libevent-dev libncurses5-dev
cd ~/src
wget "https://github.com/tmux/tmux/releases/download/${VERSION}/tmux-${VERSION}.tar.gz"
tar -xvzf tmux-${VERSION}.tar.gz
cd tmux-${VERSION}
./configure --prefix=/usr/local
make
sudo make install

# Check version
tmux -V
```

### Install GPG2

```bash
# GPG2 was already installed and it was 2.0.22. 
# Installing GPG2 from source. First, installing dependencies..
curl -L -O https://www.gnupg.org/ftp/gcrypt/npth/npth-1.5.tar.bz2
tar -xvjf npth-1.5.tar.bz2
cd npth-1.5
./configure
make
sudo make install

curl -L -O https://www.gnupg.org/ftp/gcrypt/libgpg-error/libgpg-error-1.27.tar.bz2
tar -xvjf libgpg-error-1.27.tar.gz2
cd libgpg-error-1.27
./configure
make
sudo make install

curl -L -O https://www.gnupg.org/ftp/gcrypt/libgcrypt/libgcrypt-1.8.2.tar.bz2
tar -xvjf libgcrypt-1.8.2.tar.bz2
cd libgcrypt-1.8.2
./configure
make
sudo make install

curl -L -O https://www.gnupg.org/ftp/gcrypt/libksba/libksba-1.3.5.tar.bz2
tar -xvjf libksba-1.3.5.tar.bz2
cd libksba-1.3.5
./configure
make
sudo make install

curl -L -O https://www.gnupg.org/ftp/gcrypt/libassuan/libassuan-2.5.1.tar.bz2
tar -xvjf libassuan-2.5.1.tar.bz2
cd libassuan-2.5.1
./configure
make
sudo make install

curl -L -O https://www.gnupg.org/ftp/gcrypt/ntbtls/ntbtls-0.1.2.tar.bz2
tar -xvjf ntbtls-0.1.2.tar.bz
cd ntbtls-0.1.2
./configure
make
sudo make install

# Installing gnupg depencies first from source
curl -L -O https://www.gnupg.org/ftp/gcrypt/gnupg/gnupg-2.2.3.tar.bz2
tar -xvjf gnupg-2.2.3.tar.bz2
cd gnupg-2.2.3
./configure --prefix=/usr/local
make
sudo make install

# Clear the ld.so.cache and regenrate it
cd /etc/ld.so.conf.d/
sudo vim gnupg.conf
# Add /usr/local/lib and save the file
sudo rm /etc/ld.so.cache
sudo ldconfig

# Make S3 object (https://s3.console.aws.amazon.com/s3/object/us-east-1-anand-files/misc-files/dotgnupg.tar.gz?region=us-east-1&tab=overview) public using AWS Console
cd ~/src
curl -O https://s3.amazonaws.com/us-east-1-anand-files/misc-files/dotgnupg.tar.gz
tar -xvzf dotgnupg.tar.gz
mv ~/.gnupg ~/.gnupg.bk
mv dotgnupg ~/.gnupg

# Check version
gpg --version

# Check if the key got setup correctly
gpg --list-keys --keyid-format LONG
```

### Install Java
[Source](https://www.digitalocean.com/community/tutorials/how-to-install-java-with-apt-get-on-ubuntu-16-04)

```bash
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install oracle-java8-installer
sudo apt-get install oracle-java9-installer
# Run the following command to get a sense of where JDK 8 (or 9) got installed
sudo update-alternatives --config java
# Setup a symlink in /usr/local so that JAVA_HOME environment variable picks the right version too
sudo ln -s /usr/lib/jvm/java-8-oracle /usr/local/java

# Check version
java -version
```

###  Install Maven

```bash
cd /usr/local/src
curl -O http://www-us.apache.org/dist/maven/maven-3/3.5.2/binaries/apache-maven-3.5.2-bin.tar.gz
tar -xvzf apache-maven-3.5.2-bin.tar.gz
sudo mv apache-maven-3.5.2 /usr/local/maven

# Check the version
mvn --version
```

###  Install Gradle

```bash
cd /usr/local/src
curl -O -L "https://services.gradle.org/distributions/gradle-4.6-bin.zip"
unzip gradle-4.6-bin.zip
sudo mv gradle-4.6 /usr/local/gradle

# Check the version
gradle --version
```

###  Install Groovy

```bash
cd /usr/local/src
curl -O -L "https://dl.bintray.com/groovy/maven/apache-groovy-binary-2.4.12.zip"
unzip apache-groovy-binary-2.4.12.zip
sudo mv groovy-2.4.12 /usr/local/groovy

# Check the version
groovyc -version
# Start Groovy REPL
groovysh <Hit Return>
# Type "1 + 1" or print "Hello, World". Type ":quit" to quit, ":help" for Helo
```

### Install Kotlinc

```bash
cd /usr/local/src
curl -O -L "https://github.com/JetBrains/kotlin/releases/download/v1.2.10/kotlin-compiler-1.2.10.zip"
unzip kotlin-compiler-1.2.10.zip
sudo mv kotlinc /usr/local/kotlinc

# Check the version
kotlinc -version
# Start Kotlin REPL
kotlinc-jvm <Hit Return>
# Type "1 + 1" or "Hello, World". Type ":quit" to quit, ":help" for Helo
```

### Install Go
[Source](https://github.com/udhos/update-golang)

```bash
git clone https://github.com/udhos/update-golang
cd update-golang
sudo RELEASE=1.11 ./update-golang.sh
#Update ~/.zshrc and add /usr/local/go/bin in $PATH (if not already done)
```

### Install Python

```bash
curl -O https://www.python.org/ftp/python/3.6.3/Python-3.6.3.tgz
tar -xvzf Python-3.6.3.tgz
cd Python-3.6.3
./configure --prefix=/usr/local --enable-optimizations
make
sudo make install
cd /usr/local/bin
sudo ln -s ./python3.6 python3 # If necessary
# Check version
p -V
sudo /usr/local/bin/pip3 install awscli boto3 Flask colorama paramiko parsedatetime parsimonious psutil pylint pytest prompt-toolkit requests numpy scipy pymongo
```

### Install Node
[Source](https://nodesource.com/blog/installing-node-js-8-tutorial-linux-via-package-manager/)

```bash
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt install -y nodejs

# Check version
node -v
```
Save the following content into `~/src/node-install.sh` file. Save the file. Run `chmod +x ~/src/node-install.sh`. Execute the script by typing `~/src/node-install.sh`

```bash
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
# npm install babel-cli --save-dev (Installed but had a lot of Errors when npm list command was run after the install)
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
npm install mongodb@^2.0 --save
npm install mongoskin --save
#npm install --save-dev babel-cli babel-preset-env
echo "Done!"
npm ls -g --depth=0
npm ls --depth=0
```

### Install Ruby

```bash
cd /usr/local/src
wget http://ftp.ruby-lang.org/pub/ruby/2.5/ruby-2.5.0.tar.gz
tar -xzvf ruby-2.5.0.tar.gz
cd ruby-2.5.0/
./configure --prefix=/usr/local
make
sudo make install

# Check version
ruby -v
gem -v
sudo gem install bundler rails sinatra
```

### Install Silver Searcher (Ag)

```bash
sudo apt install pkg-config libpcre3 libpcre3-dev liblzma-dev clang-format
curl -O https://geoff.greer.fm/ag/releases/the_silver_searcher-2.1.0.tar.gz
cd the_silver_searcher-2.1.0
./configure --prefix=/usr/local
make
sudo make install

# Check version
ag --version
```

### Install jq

```bash
sudo apt install jq

# Check version
jq --version
```

### Install httpie

```bash
curl -L -O https://github.com/jakubroztocil/httpie/archive/0.9.8.tar.gz
tar -xvzf 0.9.8.tar.gz
cd httpie-0.9.8
vim Makefile
# Run a global substitution: %s/pip/pip3/g
sudo make
sudo chown -R anand.anand ~/.httpie

# Check version
http --version
```

### Install diff-so-fancy

```bash
cd /usr/local/bin
sudo curl -O https://raw.githubusercontent.com/so-fancy/diff-so-fancy/master/third_party/build_fatpack/diff-so-fancy
sudo chmod 755 diff-so-fancy

# Check version
diff-so-fancy -v
```

# Cloud Native Apps on Public Clouds

### Install Docker
[Source](https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/#install-using-the-repository)

```bash
sudo apt update
# Install these to make sure apt can install packages over HTTPS
sudo apt install apt-transport-https ca-certificates curl software-properties-common
# Add Docker’s official GPG key:
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
# Verify
sudo apt-key fingerprint 0EBFCD88
# Setup stable Docker APT repository
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-cache madison docker-ce
# Source: What is apt-cache madison? Source: https://askubuntu.com/questions/447/how-can-i-see-all-versions-of-a-package-that-are-available-in-the-archive

# Install a specific version
sudo apt install docker-ce=17.09.0~ce-0~ubuntu
OR
# Install the latest
sudo apt update
sudo apt install docker-ce
sudo apt install docker-compose

# If you want to remove use of “sudo” to run docker commands, just add your Unix user to the group “docker”, assuming it exists
sudo usermod -aG docker <userid>
# Log off and log back in again for the group membership to take effect (Or try, exec su -l $USER)

# Test version
docker version
docker-compose version
# Verify installation
docker run hello-world
```

### Install Digital Ocean CLI (doctl)

```bash
cd ~/src
curl -L https://github.com/digitalocean/doctl/releases/download/v1.7.1/doctl-1.7.1-linux-amd64.tar.gz  | tar xz
sudo mv doctl /usr/local/bin

# Check version
doctl version

# Set it up
doctl auth init
doctl account get
```

### Install AWS and ECS CLI

```bash
sudo pip3 install awscli --upgrade

# Check version
aws --version

# To get authenticated, you will need AWS Key ID and Secret Key. Use "us-east-1" as the default region:
aws configure

# Install ECS CLI
sudo curl -o /usr/local/bin/ecs-cli https://s3.amazonaws.com/amazon-ecs-cli/ecs-cli-linux-amd64-latest
sudo chmod +x /usr/local/bin/ecs-cli
echo "$(curl -s https://s3.amazonaws.com/amazon-ecs-cli/ecs-cli-linux-amd64-latest.md5) /usr/local/bin/ecs-cli" | md5sum -c -

# Check version
ecs-cli --version

# Set it up
ecs-cli configure profile --profile-name sez --access-key <enter-key> --secret-key <enter-description>
ecs-cli configure profile default --profile-name sez
```

### Install Google Cloud CLI

```bash
cd src/
curl https://sdk.cloud.google.com | sudo bash
# On GCP, there is already a default version. Remove it
# cd /usr/lib; sudo rm -rf google-cloud-sdk

# Setup the link
cd /usr/local/bin
sudo ln -s /usr/local/google-cloud-sdk/bin/gcloud gcloud

# Add additional items
sudo gcloud components install kubectl alpha beta

# Check version
gcloud version
# Log out and log back in for shell completion to work

# Initialize the gcloud setup. Select 35 as Google Compute Engine zone
gcloud init --console-only
gcloud config list
```

### Install Microsoft Azure CLI

```bash
echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ wheezy main" | sudo tee /etc/apt/sources.list.d/azure-cli.list
sudo apt-key adv --keyserver packages.microsoft.com --recv-keys 417A0893
sudo apt install apt-transport-https
sudo apt update && sudo apt install azure-cli
# Check version
az --version

# Initialize the az setup.
az login
az configure
```

### Install Helm
[Source 1](https://docs.helm.sh/using_helm/#installing-helm)

```bash
cd ~/src
curl https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get > get_helm.sh
chmod +x ./get_helm.sh
./get_helm.sh
cd /usr/local/bin

# Initialize helm
helm init
helm version
```

### Install Ansible

```bash
sudo apt-add-repository ppa:ansible/ansible
sudo apt update
sudo apt install ansible

# Check version
ansible --version
```

### Install terraform

```bash
sudo apt-get install zip
curl -L "https://releases.hashicorp.com/terraform/0.11.1/terraform_0.11.1_linux_amd64.zip?_ga=2.8138800.36957763.1513534115-1088737539.1513534115" -o terraform_linux_amd64.zip
unzip terraform_linux_amd64.zip
sudo mv terraform /usr/local/bin

# Check version
terraform version
```


