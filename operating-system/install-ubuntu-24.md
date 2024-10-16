# Setting up Ubuntu 24.04

### Create a temporary SSH config in ~/.ssh/config

```bash
Host x
    Hostname <IP address> OR <x.indrayam.com>
    Port 22
    User root
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
# This is a command to check if which softwares that are ready for an upgrade
# sudo apt list --upgradable
# libyaml-dev and libffi-dev were installed for compiling Ruby
sudo apt install build-essential autoconf libcurl4-gnutls-dev libexpat1-dev gettext zlib1g-dev libssl-dev zsh  libevent-dev libncurses5-dev zip pkg-config libpcre3 libpcre3-dev liblzma-dev clang-format libgit2-1.7 libhttp-parser2.9 libssh2-1t64 libyaml-dev libffi-dev -y
```
### Add a user

```bash
useradd -c "Anand Sharma" -d "/home/anand" -s /bin/zsh -m anand
su - anand
mkdir -p ~/.ssh
chmod 700 ~/.ssh
cd .ssh
vim authorized_keys
# Add your laptop public key to authorized_keys file (id_rsa.pub)
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
```
In client SSH `~/.ssh/config`:

```bash
Host *
   ServerAliveInterval 100
   ServerAliveCountMax 100
```

In server SSHD `/etc/ssh/sshd_config`:

```bash
ClientAliveInterval 60
ClientAliveCountMax 10000
```
Restart the SSHD daemon

```bash
sudo service --status-all
sudo service ssh restart
```

### Get $HOME/src ready to download software binaries

Login as `anand`

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

```bash
ssh -T git@github.com #Check to make sure you can clone repos from Git
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
cd
git clone git@github.com:indrayam/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./setup-symlinks-linux.sh
exit
ssh <play>
# Install Vundle by running the following command:
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
```

```bash
cd ~/
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

Enable plugins:
- z
- zsh-autosuggestions
- zsh-syntax-highlighting

### Install starship CLI

```bash
cd ~
curl -sS https://starship.rs/install.sh | sh

# Update zshrc
# eval "$(starship init zsh)"

mkdir -p ~/.config
cd ~/.config
ln -s ~/.dotfiles/starship/starship.toml starship.toml
```

### Install awesome cli tools

```bash
# Install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# Install bat
sudo apt install bat
sudo ln -s /usr/bin/batcat bat

# Install fd
sudo apt install fd-find

# ripgrep
sudo apt install ripgrep

# Check version
rg --version

# Install jq
# Comes pre-installed

# Install tidy-viewer
# **NOTE** Install it after rustup installation is completed!
cargo install tidy-viewer

# Install httpie
sudo apt install httpie

# Check version
http --version

# Install diff-so-fancy
cd /usr/local/bin
sudo curl -O https://raw.githubusercontent.com/so-fancy/diff-so-fancy/master/third_party/build_fatpack/diff-so-fancy
sudo chmod 755 diff-so-fancy

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
```

### Install GPG

```bash
cd ~/src
curl -O https://storage.googleapis.com/us-east-4-anand-files/misc-files/dotgnupg.tar.gz
tar -xvzf dotgnupg.tar.gz
mv ~/.gnupg ~/.gnupg.bk
mv dotgnupg ~/.gnupg

# Check version
gpg --version

# Check if the key got setup correctly
gpg --list-keys --keyid-format LONG
```

### Install fonts-powerline

```bash
sudo apt-get install fonts-powerline
```

Also made sure that my iTerm2 was actually using a Powerline Font like *Hack Nerd Mono Font* as Non-ASCII Font

### Install nvim

Source: https://github.com/neovim/neovim/blob/master/INSTALL.md

```bash
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt-get update
sudo apt-get install neovim
```

I followed this two part tutorial to get neovim configured:
- [How to Install and Set Up Neovim for Code Editing](https://mattermost.com/blog/how-to-install-and-set-up-neovim-for-code-editing/)
- [Turning Neovim into a Full-Fledged Code Editor with Lua](https://mattermost.com/blog/turning-neovim-into-a-full-fledged-code-editor-with-lua/)


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

### Install Rust

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustc --version
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
cd ~/src
curl -L -O https://dlcdn.apache.org/maven/maven-3/3.9.9/binaries/apache-maven-3.9.9-bin.tar.gz
tar -xvzf apache-maven-3.9.9-bin.tar.gz
sudo mv apache-maven-3.9.9 /usr/local/maven

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
nvm install 22

# verifies the right Node.js version is in the environment
node -v # should print `v22.9.0`

# verifies the right npm version is in the environment
npm -v # should print `10.8.3`
```

#### Deno

```bash
curl -fsSL https://deno.land/install.sh | sh
```

#### Bun

```bash
curl -fsSL https://bun.sh/install | bash
```

### Install Go
[Source](https://github.com/udhos/update-golang)

```bash
git clone https://github.com/udhos/update-golang
cd update-golang
sudo RELEASE=1.23.2 ./update-golang.sh
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
```

### Install CMake, Jinja, gcc (latest perhaps)

### Install Julia

```bash
curl -fsSL https://install.julialang.org | sh
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
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt-get update

# Check version
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
wget -qO - https://releases.jfrog.io/artifactory/jfrog-gpg-public/jfrog_public_gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/jfrog.gpg;

# Add the JFrog repository to your APT sources with the signed-by option
echo "deb [signed-by=/etc/apt/keyrings/jfrog.gpg] https://releases.jfrog.io/artifactory/jfrog-debs xenial contrib" | sudo tee /etc/apt/sources.list.d/jfrog.list;

# Update the package list
sudo apt update;

# Install the JFrog CLI
sudo apt install -y jfrog-cli-v2-jf;

# Run the JFrog CLI intro command
jf intro;
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
wget https://github.com/digitalocean/doctl/releases/download/v1.115.0/doctl-1.115.0-linux-amd64.tar.gz
tar xvzf ~/doctl-1.115.0-linux-amd64.tar.gz
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
sudo git clone https://github.com/ahmetb/kubectx /opt/kubectx
sudo ln -s /opt/kubectx/kubectx /usr/local/bin/kubectx
sudo ln -s /opt/kubectx/kubens /usr/local/bin/kubens
```

### Install stern

```bash
cd ~/src
curl -L -O https://github.com/stern/stern/releases/download/v1.31.0/stern_1.31.0_linux_amd64.tar.gz
tar -xf stern_1.31.0_linux_amd64.tar.gz
sudo mv stern /usr/local/bin
```

### Install Helm

```bash
curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /etc/apt/keyrings/helm.gpg > /dev/null
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
sudo apt-get update
sudo apt-get install helm

# Initialize helm
helm init
helm version
```

### Install Data Engineering Tools

### Install sqlite3

```bash
sudo apt-get install sqlite3
```
