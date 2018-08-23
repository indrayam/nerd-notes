# Setting up CentOS

### Steps

**Basics:**

```bash
sudo apt update
sudo apt upgrade -y
sudo apt-get install -y apt-transport-https ca-certificates python-software-properties software-properties-common vim zsh curl wget tar zip socat jq silversearcher-ag
sudo add-apt-repository -y ppa:jonathonf/vim
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list 
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-get update
sudo apt install -y vim
```

**Configure Shell:**

```bash
sudo su
vim /etc/passwd
# Change default shell of the current user to zsh (/bin/zsh)
cd ~
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/indrayam/dotfiles.git ~/.dotfiles
cd .dotfiles
./setup-symlinks-unix.sh
cd
```

**Configure Vim:**

```bash
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
```

**Setup SSH Keys:**

```bash
mkdir -p ~/src
cd ~/src
curl -O -L https://storage.googleapis.com/us-east-4-anand-files/misc-files/linux-bootstrap.tar.gz.enc -H 'Accept: application/octet-stream'
openssl aes-256-cbc -d -in linux-bootstrap.tar.gz.enc -out linux-bootstrap.tar.gz
tar -xvzf linux-bootstrap.tar.gz
mv ssh/* ~/.ssh/
mv config ~/.config
chmod 700 ~/.ssh/
rm -rf ssh/ ssh.tar.gz
ssh -o "StrictHostKeyChecking no" -T git@github.com
```
