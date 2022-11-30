# Install MacOS (Ventura)

## Software

**Core software and configurations:**
- Google Chrome
- Dropbox
- OneDrive
- WhatsApp
- Skype
- Grammarly Desktop

**Apple App Store Apps:**
- Kindle
- GarageBand
- iMovie
- Medis
- Xcode
- PasteBox
- Dato
- Magnet
- Unsplash Wallpapers

**Cisco-centric software and configurations:**
- MS Office
- Webex
- Duo Device Health
- Cisco AnyConnect
- Cisco Secure Endpoint Connector (?)
- Code42
- Mac at Cisco (Self-Service)
- VMWare Fusion 13 (when available)

**My Non-Development Software:**
- Evernote
- Sublime Text (Needs license)
- SnagIt (Needs license)
- DaisyDisk

**My Development UI Software:**
- iTerm2
- VSCode
- VirtualBox
- Multipass
- Transmit
- Jetbrains Toolbox
- Docker Desktop
- Podman Desktop

**My Development Core CLI Software:**
- `brew`

As a CLI nerd, a whole slew of software will get installed using `brew` listed here: `~/Dropbox/workspace/cloud-configurations/brew/brew-install.txt`

## Custom configurations and configuration files

**UI App Needing Custom configurations:**
- iTerm2
- VS Code
- Chrome

**Custom Configuration Files:**
- `.3T`
- `.anyconnect`
- `.aws -> /Users/anasharm/Dropbox/workspace/cloud-configurations/aws`
- `.azure -> /Users/anasharm/Dropbox/workspace/cloud-configurations/azure`
- `.cargo` (list of binaries)
- `.codectl.yaml -> /Users/anasharm/Dropbox/workspace/cloud-configurations/.config`
- `config/gcloud`
- `config/gh`
- `config/iterm2`
- `config/nvim`
- `config/pgcli`
- `config/starship.toml`
- `config/topgrade.toml`
- `.dotfiles`
- `.dotkube`
- `.gem` (not sure about this one)
- `.gitconfig -> /Users/anasharm/.dotfiles/git/gitconfig`
- `.gitignore_global -> /Users/anasharm/.dotfiles/git/gitignore_global`
- `.gnupg -> /Users/anasharm/Dropbox/workspace/cloud-configurations/gnupg`
- `.go` (list of binaries)
- `.jfrog` (configuration to connect to artifactory)
- `.julia` (not sure what the config files are for)
- `.kube -> /Users/anasharm/.dotkube`
- `.ldaprc -> /Users/anasharm/.dotfiles/ldap/ldaprc`
- `.local` (used by podman, podman-desktop, nvim plugins, sfdx)
- `.oh-my-zsh`
- `.pgpass -> /Users/anasharm/Dropbox/workspace/cloud-configurations/psql/.podman-desktop`
- `.sfdx`
- `.sfdx-code -> /Users/anasharm/Dropbox/workspace/cloud-configurations/.sfdx-scanner`
- `.ssh -> /Users/anasharm/Dropbox/workspace/cloud-configurations/ssh`
- `.thinkorswim`
- `.ticker.yaml -> /Users/anasharm/Dropbox/workspace/cloud-configurations/ticker/ticker.yaml`
- `.tijori -> workspace/cloud-configurations/tijori/all.sh`
- `.tmux.conf -> /Users/anasharm/.dotfiles/tmux/tmux.conf`
- `.tmux.conf.local -> /Users/anasharm/.dotfiles/tmux/tmux.conf.local`
- `.vim -> /Users/anasharm/.dotfiles/vim`
- `.vimrc -> /Users/anasharm/.dotfiles/vim/vimrc`
- `.vscode`
- `.wrangler -> workspace/cloud-configurations/wrangler`
- `.z`
- `.zsh_history`
- `.zshrc -> /Users/anasharm/.dotfiles/zsh/zshrc`

## Notes: Power up and the basics

- Power on the MacBook
- Choose your country and select your keyboard preferences
- Connect to Wi-Fi network
- Enter the Apple ID and connect to iCloud
- Setup the Unix Account
  Full Name
  Account Name
  Password
  Password Verify
  Hint
- System Preferences | Dock (Add Maginification, reduce size)
- System Preferences | Trackpad (Add Tap to Click; Remove Scroll direction setting of "Normal")
- Setup Siri
- Setup TouchID

## Notes: Setup ComputerName

```bash
sudo scutil --set HostName macbook16.local
sudo scutil --set ComputerName macbook16
dscacheutil --flushcache
```
## Notes: Install App Store apps

Install `mas` and use it to install these apps:
- Kindle
- GarageBand
- iMovie
- Medis
- Xcode
- PasteBox
- Dato
- Magnet
- Unsplash Wallpapers


```bash
mas login
mas install 405399194
mas install 682658836
mas install 408981434
mas install 1063631769
mas install 497799835
mas install 928940999
mas install 1470584107
mas install 441258766
mas install 1284863847
```

## Notes: Keyboard
- English
- Hindi Transliteration

## Notes: Cisco Setup

- [Start here](https://hybridworkerportal.cisco.com/home)

## Install XCode Command Line Tools

```bash
xcode-select --install
xcode-select -p
```

## Install Homebrew Cask Formulas

Source: [Homebrew.sh Formulas](https://formulae.brew.sh/cask/)

```bash
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew tap homebrew/cask-fonts
brew update
brew cask install iterm2
```

## Install Developer Fonts

- Copy fonts from `~/Dropbox/workspace/cloud-configurations/fonts/*` to `~/Library/Fonts`

## Configure iTerm2

- [Sync your iTerm2 Settings and Configs between devices](https://shyr.io/blog/sync-iterm2-configs)