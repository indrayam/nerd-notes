# Setting up CentOS 7.4

### Create a temporary SSH config

```bash
Host c
    Hostname <IP address> OR <c.indrayam.com>
    Port 22
    User root
    IdentityFile ~/.ssh/id_rsa
```

### Update, upgrade and get basic software for compiling from source
[Source](https://wiki.centos.org/AdditionalResources/Repositories)

```bash
yum update
yum upgrade
yum install wget
# Approach 1
wget http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
rpm -ivh epel-release-latest-7.noarch.rpm
OR
# Approach 2
sudo yum install epel-release
# Check Repo Listing
yum repolist

# To get info or install a repo specifically from EPEL repo, use commands like the following
# yum --enablerepo=epel info curl
# yum --enablerepo=epel install curl
sudo yum groupinstall "Development tools"
sudo yum install vim patch zsh curl-devel expat-devel openssl-devel zlib-devel readline-devel sqlite-devel libxml2-devel libxslt libxslt-devel libtool-ltdl-devel bzip2-devel pcre-devel httpd-devel tree jq ncurses-devel libevent-devel perl-CPAN bind-utils libffi-devel curl wget
```
### Add a user
```bash
adduser anand (It will prompt for all the entries in /etc/passwd) 
OR
useradd -c "Anand Sharma" -d "/home/anand" -s /bin/zsh anand
```

### Add user to sudo
```bash
# These steps are not required for a VM on GCP
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

# Check version
git --version
```

### Install latest Vim

```bash
cd ~/src
curl -L -O https://github.com/vim/vim/archive/v8.0.1391.tar.gz
tar -xvzf v8.0.1391.tar.gz
cd vim-8.0.1391
./configure --prefix=/usr/local
make
sudo make install

#Check version
vim --version
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
```

### Install latest tmux
[Source](https://gist.github.com/indrayam/ebf53ba970241694865e1dd2b1313945)

```bash
# Steps to build and install tmux from source on Ubuntu.
# Takes < 25 seconds on EC2 env [even on a low-end config instance].
VERSION=2.6
sudo yum -y remove tmux
# If installing tmux in sequence, the next step is OPTIONAL
# sudo yum -y install libevent-devel ncurses-devel
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

# Check version
gpg --version

# Check if the key got setup correctly
gpg --list-keys --keyid-format LONG
```

### Install Java
[Source](https://www.digitalocean.com/community/tutorials/how-to-install-java-on-centos-and-fedora)

```bash
cd ~/src
# Download and install JDK 1.8
wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u152-b16/aa0333dd3019491ca4f6ddbe78cdb6d0/jdk-8u152-linux-x64.rpm"
sudo yum localinstall jdk-8u152-linux-x64.rpm
# Download and install JDK 9
wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/9.0.1+11/jdk-9.0.1_linux-x64_bin.rpm"
sudo yum localinstall jdk-9.0.1_linux-x64_bin.rpm
# These steps will install the versions inside /usr/java/. Map the "latest" soft link to the JDK version you want to use
sudo update-alternatives --config java
# Setup a symlink in /usr/local so that JAVA_HOME environment variable picks the right version too
sudo ln -s /usr/java/latest /usr/local/java

# Check version
java -version
```

###  Install Maven

```bash
cd /usr/local/src
curl -O -L http://www-us.apache.org/dist/maven/maven-3/3.5.2/binaries/apache-maven-3.5.2-bin.tar.gz
tar -xvzf apache-maven-3.5.2-bin.tar.gz
sudo mv apache-maven-3.5.2 /usr/local/maven

# Check the version
mvn --version
```

###  Install Gradle

```bash
cd /usr/local/src
curl -O -L "https://services.gradle.org/distributions/gradle-4.4-bin.zip"
unzip gradle-4.4-bin.zip
sudo mv gradle-4.4 /usr/local/gradle

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
# Type "1 + 1" or println("Hello, World"). Type ":quit" to quit, ":help" for Helo
```

### Install Go
[Source](https://github.com/udhos/update-golang)

```bash
cd ~/src
git clone https://github.com/udhos/update-golang
cd update-golang
sudo RELEASE=1.9.2 ./update-golang.sh
Update ~/.zshrc and add /usr/local/go/bin in $PATH (if not already done)

# Check version
go version
```

### Install Python

```bash
cd ~/
curl -O https://www.python.org/ftp/python/3.6.3/Python-3.6.3.tgz
tar -xvzf Python-3.6.3.tgz
cd Python-3.6.3
./configure --prefix=/usr/local --enable-optimizations
make
sudo make install
cd /usr/local/bin
ln -s ./python3.6 python3 # If necessary

# Check version
p -V
sudo /usr/local/bin/pip3 install awscli boto3 Flask colorama paramiko parsedatetime parsimonious psutil pylint pytest prompt-toolkit requests numpy scipy pymongo
```

### Install Node
[Source](https://nodesource.com/blog/installing-node-js-8-tutorial-linux-via-package-manager/)

```bash
curl -sL https://rpm.nodesource.com/setup_8.x | sudo bash -
sudo yum install -y nodejs

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
wget http://ftp.ruby-lang.org/pub/ruby/2.4/ruby-2.4.3.tar.gz
tar -xzvf ruby-2.4.3.tar.gz
cd ruby-2.4.3/
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
sudo yum install -y pcre-devel xz-devel
cd ~/src
curl -L -O https://geoff.greer.fm/ag/releases/the_silver_searcher-2.1.0.tar.gz
cd the_silver_searcher-2.1.0
./configure --prefix=/usr/local
make
sudo make install

# Check version
ag --version
```

### Install jq

```bash
curl -L -O https://github.com/stedolan/jq/releases/download/jq-1.5/jq-1.5.tar.gz
tar -xvzf jq-1.5.tar.gz
cd jq-1.5/
autoreconf -i
./configure --disable-maintainer-mode --prefix=/usr/local
make
sudo make install

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

# Check version
http --version
```

### Install diff-so-fancy

```bash
cd /usr/local/bin
sudo curl -O https://raw.githubusercontent.com/so-fancy/diff-so-fancy/master/third_party/build_fatpack/diff-so-fancy
sudo chmod +x diff-so-fancy

# Check version
diff-so-fancy -v
```

# Cloud Native Apps on Public Clouds

### Install Docker
[Source](https://docs.docker.com/engine/installation/linux/docker-ce/centos/)

```bash
# Remove older versions of Docker
sudo yum remove docker docker-common docker-selinux docker-engine
# Setup the repository
sudo yum install -y yum-utils device-mapper-persistent-data lvm2
# Setting up stable repository. You need this regardless of whether you decide to run the edge or test repositories
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
# Optional: Enable edge and test repositories. They are included in docker.repo file above but are disabled by default. You can enable them alongside the stable repository
# sudo yum-config-manager --enable docker-ce-edge
#sudo yum-config-manager --enable docker-ce-test
# Disable edge or test by running this command
# sudo yum-config-manager --disable docker-ce-edge

# Install Docker-CE
# On Production systems, you should always install a specific version instead of always using the latest. List the available versions. This example uses the sort -r command to sort the results by version number, highest to lowest. The second column is the version string. To install a specific version, append the version string to the package name and separate them by a hyphen (-).
yum list docker-ce --showduplicates | sort -r
# Install a specific version
sudo yum install docker-ce-17.09.1.ce-1.el7.centos
OR
sudo yum install docker-ce # To download the latest
sudo yum install docker-compose

# Start Docker
sudo systemctl start docker

# If you want to remove use of “sudo” to run docker commands, just add your Unix user to the group “docker”, assuming it exists
sudo usermod -aG docker <userid>

# Test version
docker version
docker-compose version
# Verify installation
sudo docker run hello-world
```

### Install Digital Ocean CLI (doctl)

```bash
cd ~/src
curl -L -O https://github.com/digitalocean/doctl/releases/download/v1.7.1/doctl-1.7.1-linux-amd64.tar.gz
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

# To get authenticated, you will need AWS Key ID and Secret Key:
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

# Setup the link
cd /usr/local/bin
sudo ln -s /usr/local/google-cloud-sdk/bin/gcloud gcloud

# Add additional items
sudo gcloud components install kubectl alpha beta

# Check version
gcloud version
# Log out and log back in for shell completion to work

# Initialize the gcloud setup. Select 35 as Google Compute Engine zone
gcloud init
gcloud config list
```

### Install Microsoft Azure CLI

```bash
# Import the Microsoft Key
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
# Create local azure-cli repository information:
sudo sh -c 'echo -e "[azure-cli]\nname=Azure CLI\nbaseurl=https://packages.microsoft.com/yumrepos/azure-cli\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/azure-cli.repo'
# Update the yum package index and install:
yum check-update
sudo yum install azure-cli
# Check version
az --version

# Initialize the az setup. 
az login
az configure
```

### Install Kubernetes Helm
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
# sudo yum install epel-release
sudo yum install ansible

# Check version
ansible --version
```

### Install terraform

```bash
cd ~/src
curl -L "https://releases.hashicorp.com/terraform/0.11.1/terraform_0.11.1_linux_amd64.zip?_ga=2.8138800.36957763.1513534115-1088737539.1513534115" -o terraform_linux_amd64.zip
unzip terraform_linux_amd64.zip
sudo mv terraform /usr/local/bin

# Check version
terraform version
```




