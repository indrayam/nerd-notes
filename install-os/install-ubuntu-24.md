# Setting up Ubuntu 24.04

### iTerm2

Make sure that my iTerm2 was actually using a Powerline Font like *Hack Nerd Mono Font* as Non-ASCII Font

### Create a temporary SSH config in ~/.ssh/config

```bash
Host x
    Hostname <IP address> OR <x.indrayam.com>
    Port 22
    User <user-id>
```

To find out what version of Ubuntu you are running, use the following command:

```bash
lsb_release -a

```

### Update, upgrade and get basic software for compiling from source

```bash
sudo apt update
sudo apt upgrade
# Install upgrades that might have been held back
sudo unattended-upgrades
# This is a command to check which softwares that are ready for an upgrade
# sudo apt list --upgradable
# libyaml-dev and libffi-dev were installed for compiling Ruby
sudo apt install build-essential autoconf libcurl4-gnutls-dev libexpat1-dev gettext zlib1g-dev libssl-dev zsh tree  libevent-dev libncurses-dev zip pkg-config libpcre3 libpcre3-dev liblzma-dev clang-format libgit2-1.7 libhttp-parser2.9 libssh2-1t64 libyaml-dev libffi-dev -y
```
### Add a user (only if the cloud provider dumps you into root account)

```bash
useradd -c "Anand Sharma" -d "/home/anand" -s /bin/zsh -m anand
su - anand
mkdir -p ~/.ssh
chmod 700 ~/.ssh
cd .ssh
vim authorized_keys
# Add your laptop public key to authorized_keys file (id_rsa.pub)
```
### Add user to sudo (only if a new user account was created)

```bash
# Approach 1
sudo visudo
# Add this line below the configuration for the root user
#<userid>    ALL=(ALL:ALL) NOPASSWD:ALL

# Approach 2
cd /etc
chmod 640 sudoers
# Add this line below the configuration for the root user
#<userid>    ALL=(ALL:ALL) NOPASSWD:ALL
chmod 440 sudoers
```

### SSH configuration for <userid> (only if a new user account was created)


```bash
# If scp is possible...
# scp ~/.ssh/play_id_ed25519 play1-aws:/home/ubuntu/.ssh/

su - <userid>
mkdir -p ~/.ssh
chmod 700 ~/.ssh
cd ~/.ssh
vim authorized_keys
# On your local Mac, run
# cat ~/.ssh/id_rsa.pub | pbcopy
# Paste the content to the authorized_keys and save the file on the server
# Do the same for play credentials
vim config
# Copy-n-paste this
# Host play1
#   Hostname play1.anandsharma.dev
#   IdentityFile ~/.ssh/id_ed25519
#   User anand

# Host play2
#   Hostname play2.anandsharma.dev
#   IdentityFile ~/.ssh/id_ed25519
#   User anand
```

### SSH login using RSA authentication

```bash
Update ~/.ssh/config with the following changes:
Host x
    Hostname <IP address> OR <x.indrayam.com>
    Port 22
    User anand
    IdentityFile ~/.ssh/id_rsa
```
On the client, update the SSH configuration file `~/.ssh/config`:

```bash
Host *
   ServerAliveInterval 100
   ServerAliveCountMax 100
```

On the server, update the SSHD configuration file `/etc/ssh/sshd_config`:

```bash
sudo vim /etc/ssh/sshd_config
Add the two lines shown below to the end of the file:
ClientAliveInterval 60
ClientAliveCountMax 10000
```
Restart the SSHD daemon

```bash
sudo service --status-all
sudo service ssh restart
```

### Get $HOME/src ready to download software binaries

Login as <user-id>

```bash
mkdir -p ~/src
```

### Install latest Git

```bash
curl -L -O https://github.com/git/git/archive/refs/tags/v2.47.0.tar.gz
tar -xvzf v2.47.0.tar.gz
cd git-2.47.0
make configure
./configure --prefix=/usr/local
make all
sudo make install

# Check version
git --version
```

### Install oh-my-zsh and dotfiles.git repo from GitHub

Upload the `play` VM certs to the new server

```bash
cd ~/.ssh
sftp <playN>
cd .ssh
mput play_id*
```

```bash
ssh -T git@github.com #Check to make sure you can clone repos from Git
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
cd

# Installing starship cli prompt
cd ~
curl -sS https://starship.rs/install.sh | sh

# The steps below should not be necessary. Adding here for completeness sake...
# eval "$(starship init zsh)"
# mkdir -p ~/.config
# cd ~/.config
# ln -s ~/.dotfiles/starship/starship.toml starship.toml

# Installing configurations
git clone git@github.com:indrayam/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./setup-symlinks-linux.sh
exit
ssh <play>

# Installing Zsh plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Install Vundle by running the following command:
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
```

If you ever delete `~/.dotfiles` folder, you will need to run these steps again:

```bash
./setup-symlinks-linux.sh
# Install Vundle by running the following command:
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```


### Install awesome cli tools

```bash
# Install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# Install bat
sudo apt install bat
sudo ln -s /usr/bin/batcat /usr/local/bin/bat

# Install fd
sudo apt install fd-find

# ripgrep
sudo apt install ripgrep

# Check version
rg --version

# Install jq
# Comes pre-installed

# Install httpie
sudo apt install httpie

# Check version
http --version

# Install diff-so-fancy
cd ~/src
git clone git@github.com:so-fancy/diff-so-fancy.git
sudo mv diff-so-fancy /usr/local
cd /usr/local/bin
sudo ln -s ../diff-so-fancy/diff-so-fancy diff-so-fancy

# Check version
diff-so-fancy -v

```

### Configure latest tmux

```bash
tmux -V
```

```bash
cd
git clone https://github.com/gpakosz/.tmux.git
ln -s -f .tmux/.tmux.conf
cp .tmux/.tmux.conf.local .
t # or tmux and then Hit enter
# Ctrl+A D (or Ctrl+B D) to detach
t ls
# Kill session
t kill-session -t 0
# If you want to do a little test, go through exercises on this [article](https://www.redhat.com/en/blog/introduction-tmux-linux)
```

### Install GPG

```bash

# GPG should already be installed
gpg --version

# Run the command below to initialize GPG or it should just return nothing
gpg --list-keys
# If the .gnupg folder does not exist, you should see something like...
# gpg: directory '/Users/<userid>/.gnupg' created
# gpg: /Users/<userid>/.gnupg/trustdb.gpg: trustdb created

# Download your exported keys
cd ~/src
curl -O -L https://storage.googleapis.com/us-east-4-anand-files/misc-files/dotgnupg.tar.gz
tar -xf dotgnupg.tar.gz

# Import your keys on the Linux VM
# It will (re)prompt for the passphrase(s) of the private keys
cd gnupg
gpg --import myprivatekeys.asc
gpg --import mypubkeys.asc
gpg -K
gpg -k
# Optionally import the trustdb file
gpg --import-ownertrust otrust.txt

# Check if the key got setup correctly
gpg --list-keys --keyid-format LONG
```

### Install fonts-powerline

SKIP

```bash
sudo apt-get install fonts-powerline
```

### Install nvim

Source: https://github.com/neovim/neovim/blob/master/INSTALL.md

```bash
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt-get update
sudo apt-get install neovim
```

Install [LazyVim](https://www.lazyvim.org/)

```bash
# required
test -e ~/.config/nvim && mv ~/.config/nvim{,.bak}

# optional but recommended
test -e ~/.local/share/nvim && mv ~/.local/share/nvim{,.bak}
test -e ~/.local/state/nvim && mv ~/.local/state/nvim{,.bak}
test -e ~/.cache/nvim && mv ~/.cache/nvim{,.bak}

# install lazyvim
git clone https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git

# Run nvim to install all plugins
nvim
```

### Install Rust

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustc --version
```

# Install tidy-viewer
# **NOTE** Install it after rustup installation is completed!
cargo install tidy-viewer
tv --version
wget https://raw.githubusercontent.com/tidyverse/ggplot2/master/data-raw/diamonds.csv
cat diamonds.csv | head -n 35 | tv
tv diamonds.csv


### Install Python

```bash
curl -L -O https://www.python.org/ftp/python/3.13.0/Python-3.13.0.tgz
tar -xvzf Python-3.13.0.tgz
cd Python-3.13.0
./configure --prefix=/usr/local --enable-optimizations
make
sudo make install
cd /usr/local/bin
sudo ln -s ./python3.13 python3 # If necessary
# Check version
p -V

# Create a python virtual environment
# python3 -m venv ~/dev/py/1/venv1
# source ~/dev/py/1/venv1/bin/activate
# python -m pip install awscli boto3 Flask colorama paramiko parsedatetime parsimonious psutil pylint pytest prompt-toolkit requests numpy scipy pymongo
```

Using Python Package and Project Manager...

```bash
# install uv and uvx
curl -LsSf https://astral.sh/uv/install.sh | sh
uv python list
uv python install 3.13.0

# install conda
# Install our public GPG key to trusted store
curl https://repo.anaconda.com/pkgs/misc/gpgkeys/anaconda.asc | gpg --dearmor > conda.gpg
sudo install -o root -g root -m 644 conda.gpg /etc/apt/keyrings/conda-archive-keyring.gpg

# Check whether fingerprint is correct (will output an error message otherwise)
gpg --keyring /etc/apt/keyrings/conda-archive-keyring.gpg --no-default-keyring --fingerprint 34161F5BF5EB1D4BFBBB8F0A8AEB4F8B29D82806

# Add our Debian repo
echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/conda-archive-keyring.gpg] https://repo.anaconda.com/pkgs/misc/debrepo/conda stable main" | sudo tee -a /etc/apt/sources.list.d/conda.list

# Install
sudo apt-get update
sudo apt-get install conda

```

### Install Java

Using SDKMAN

```bash
curl -s "https://get.sdkman.io" | bash
# If the shell script is not sourced..
#export SDKMAN_DIR="$HOME/.sdkman"
#[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk help
sdk list java | grep 21
sdk install java
java -version
```

###  Install Maven

```bash
sdk install maven

# Check the version
mvn --version
```

### Install GFortran

```bash
sudo apt install gfortran
```

### Install JavaScript Runtimes

#### Node

```bash
# installs nvm (Node Version Manager)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh | bash

# download and install Node.js (you may need to restart the terminal)
nvm set-colors cgYmW
nvm install 22
nvm install --lts # install the latest LTS version
nv use --lts # use the latest LTS version
nvm install node # to install the latest node version
nvm use node # use the latest node

# verifies the right Node.js version is in the environment
node -v # should print `v22.10.0`

# verifies the right npm version is in the environment
npm -v # should print `10.8.3`
npm update
```

#### Deno

```bash
curl -fsSL https://deno.land/install.sh | sh
deno --version
deno --help
```

#### Bun

```bash
curl -fsSL https://bun.sh/install | bash
bun --version
bun --help
```

### Install Go
[Source](https://askubuntu.com/a/1377308)

```bash
sudo add-apt-repository ppa:longsleep/golang-backports
sudo apt update
sudo apt install golang-1.23
go version
```


### Install Ruby

```bash
cd ~/src
curl -fsSL https://github.com/rbenv/rbenv-installer/raw/HEAD/bin/rbenv-installer | bash
rbenv install -l
rbenv install 3.3.5
rbenv global 3.3.5
#OR
#rbenv local 3.3.5

# Check version
ruby -v
gem -v
# DO NOT USE sudo
# These will all be installed under ~/.rbenv/.. folder
gem install bundler rails
gem update --system 3.5.22
```

### Install CMake and Ninja

```bash
# install cmake
# curl -L -O https://github.com/Kitware/CMake/releases/download/v3.30.5/cmake-3.30.5.tar.gz
# tar -xf cmake-3.30.5.tar.gz
# cd cmake-3.30.5
# ./boostrap
# make
# sudo make install
sudo apt-get install cmake # installs 3.28.3
cmake --version
# ninja
sudo apt-get install ninja-build
ninja --version
```

### Install Julia

```bash
curl -fsSL https://install.julialang.org | sh
julia --version # OR 
jl --version
```

# Cloud Native Apps on Public Clouds

### Install Docker
[Source](https://docs.docker.com/engine/install/ubuntu/)

```bash
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done
sudo rm -rf /var/lib/docker
sudo rm -rf /var/lib/containerd

# Add Docker's official GPG key:
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

# Install a specific version
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# If you want to remove use of “sudo” to run docker commands, just add your Unix user to the group “docker”, assuming it exists
sudo usermod -aG docker $USER
# Log off and log back in again for the group membership to take effect (Or try, exec su -l $USER)

# Test version
docker version
docker compose version
# Verify installation
docker run hello-world
```

### Install podman

```bash
sudo apt-get install podman
podman --version
podman info
podman run -it hello-world
```

### Install Terraform and Terragrunt

```bash
# Install Terraform
sudo apt-get update
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/hashicorp-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt-get update

# Check version
sudo apt-get install terraform
terraform --version
# OR
tf -v
tf -help

# Install Terragrunt
cd ~/src
curl -L -O https://github.com/gruntwork-io/terragrunt/releases/download/v0.68.1/terragrunt_linux_amd64
mv terragrunt_linux_amd64 terragrunt
chmod +x terragrunt
sudo mv terragrunt /usr/local/bin

# Check version
terragrunt --version
# OR
tg -v
tg -help
```

### Install Ansible

```bash
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt update
sudo apt install ansible

# Check version
ansible --version
```

### Install Jfrog CLI

```bash
# Download and save the JFrog GPG key to a keyring file
wget -qO - https://releases.jfrog.io/artifactory/jfrog-gpg-public/jfrog_public_gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/jfrog.gpg

# Add the JFrog repository to your APT sources with the signed-by option
echo "deb [signed-by=/etc/apt/keyrings/jfrog.gpg] https://releases.jfrog.io/artifactory/jfrog-debs xenial contrib" | sudo tee /etc/apt/sources.list.d/jfrog.list

# Update the package list
sudo apt update

# Install the JFrog CLI
sudo apt install -y jfrog-cli-v2-jf

# Run the JFrog CLI intro command
jf intro
jf login

# Shell completion
jf completion zsh --install
```

### Install Hashicorp Vault

```bash
# Get the GPG
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/hashicorp-archive-keyring.gpg

# Configure the APT repos
echo "deb [signed-by=/etc/apt/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

# Update and install vault using apt
sudo apt update && sudo apt install vault

# Check client version
vault version

# Notice the server is not started by default as my plan is to play with the client (for now)
```

### Install Digital Ocean CLI (doctl)

```bash
cd ~/src
curl -L -O https://github.com/digitalocean/doctl/releases/download/v1.115.0/doctl-1.115.0-linux-amd64.tar.gz
tar -xf ~/doctl-1.115.0-linux-amd64.tar.gz
sudo mv doctl /usr/local/bin

# Check version
doctl version

# Set it up
doctl auth init
doctl compute droplet list
doctl account get
```

### Install AWS and ECS CLI

```bash
cd ~/src
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install --bin-dir /usr/local/bin --install-dir /usr/local/aws-cli --update

# Check version
aws --version

# To get authenticated, you will need AWS Key ID and Secret Key. Use "us-east-1" as the default region:
aws configure
    
```

### Install Google Cloud CLI

```bash
cd ~/src
curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-linux-x86_64.tar.gz
tar -xf google-cloud-cli-linux-x86_64.tar.gz
./google-cloud-sdk/install.sh
sudo mv google-cloud-sdk /usr/local/
sudo ln -s /usr/local/google-cloud-sdk/bin/gcloud /usr/local/bin/gcloud

# Check version
gcloud version
# Log out and log back in for shell completion to work

# Initialize the gcloud setup. Select 35 as Google Compute Engine zone
gcloud init --console-only
gcloud config list
```

### Install Openstack Client

```bash
sudo apt-get install python3-openstackclient
# On a MacOS, you can do..
# brew install openstackclient
openstack --version
```

### Install kubectl

```bash
# If the folder `/etc/apt/keyrings` does not exist, it should be created before the curl command, read the note below.
# sudo mkdir -p -m 755 /etc/apt/keyrings
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.31/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
sudo chmod 644 /etc/apt/keyrings/kubernetes-apt-keyring.gpg # allow unprivileged APT programs to read this keyring

# This overwrites any existing configuration in /etc/apt/sources.list.d/kubernetes.list
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.31/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo chmod 644 /etc/apt/sources.list.d/kubernetes.list   # helps tools such as command-not-found to work correctly

# To upgrade kubectl to another minor release, you'll need to bump the version in /etc/apt/sources.list.d/kubernetes.list before running apt-get update and apt-get upgrade. This procedure is described in more detail in Changing The Kubernetes Package Repository.
sudo apt-get update
sudo apt-get install -y kubectl
kubectl version --client=true
```

### Install Kubectl Krew plugin manager

```bash
(
  set -x; cd "$(mktemp -d)" &&
  OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
  ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
  KREW="krew-${OS}_${ARCH}" &&
  curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" &&
  tar zxvf "${KREW}.tar.gz" &&
  ./"${KREW}" install krew
)

# If it is not in the PATH already...
# export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

kubectl krew
kubectl krew list
```

### Install kubectx

```bash
(
sudo git clone https://github.com/ahmetb/kubectx /usr/local/kubectx
sudo ln -s /usr/local/kubectx/kubectx /usr/local/bin/kubectx
sudo ln -s /usr/local/kubectx/kubens /usr/local/bin/kubens
)
```

### Install stern

```bash
cd ~/src
curl -L -O https://github.com/stern/stern/releases/download/v1.31.0/stern_1.31.0_linux_amd64.tar.gz
tar -xf stern_1.31.0_linux_amd64.tar.gz
sudo mv stern /usr/local/bin
s --version
```

### Install Helm

```bash
curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /etc/apt/keyrings/helm.gpg > /dev/null
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
sudo apt-get update
sudo apt-get install helm

# Initialize helm
helm version
```

### Install Nginx and Certbot

```bash
# Nginx
sudo apt-get install nginx
sudo systemctl status nginx
sudo chown -R <userid>:<userid> /var/www/html
cd 
ln -s -f /var/www/html
mv inde* index.html

# Certbot
sudo apt-get install certbot
certbot --version
# Update Nginx default configuration file with the following excerpt
sudo vim /etc/nginx/sites-enabled/default
# Excerpt start...
    location ^~ /.well-known/acme-challenge/ {
            default_type "text/plain";
            root /var/www/letsencrypt;
    }
# Excerpt end.
sudo mkdir -p /var/www/letsencrypt/.well-known/acme-challenge
sudo nginx -t
sudo systemctl restart nginx

# Open two terminal windows to the server. On the first one, run certbot for generation of the certificates:

sudo certbot certonly --manual -d play1-aws.anandsharma.dev

# When prompted like the following:
# Create a file containing just this data:
# abc.def (example)
# And make it available on your web server at this URL:
# http://play1-aws.anandsharma.dev/.well-known/acme-challenge/abc (example)
# Use the second terminal window to create a file `abc` and add the following content:
# vim /var/www/letsencrypt/.well-known/acme-challenge/abc.def
# Add the data/secret prompted by certbot

# Time to test it

curl http://demo.indrayam.com/.well-known/acme-challenge/abc
# OR
http http://demo.indrayam.com/.well-known/acme-challenge/abc
```

### Install Data Engineering Tools

### Install sqlite3

```bash
sudo apt-get install sqlite3
```
