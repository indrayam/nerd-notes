# Setting up CentOS

### Steps

**Basics:**

```bash
sudo yum -y update
sudo yum -y upgrade
sudo yum -y install epel-release
sudo yum -y update
sudo yum groupinstall "Development tools"
sudo yum install vim curl wget git zsh patch curl-devel expat-devel openssl-devel zlib-devel readline-devel sqlite-devel libxml2-devel libxslt libxslt-devel libtool-ltdl-devel bzip2-devel pcre-devel httpd-devel tree jq ncurses-devel libevent-devel perl-CPAN bind-utils libffi-devel 
```

**Configure Shell:**

```bash
sudo su
vim /etc/passwd
# Change default shell of the current user to zsh (/bin/zsh)
git clone https://github.com/indrayam/dotfiles.git ~/.dotfiles
cd ~
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
cd .dotfiles
./setup-symlinks-centos.sh
cd
```

**Configure Vim:**

```bash
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
```

**Install Nginx:**

```bash
sudo yum install nginx
sudo systemctl start nginx
```
