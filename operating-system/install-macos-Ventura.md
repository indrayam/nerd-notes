# Install MacOS (Ventura) on M1/M2

## Notes: Initial Setup
- [Start here for Cisco](https://hybridworkerportal.cisco.com/home)
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

## Core Software

**Core software and configurations:**
- Google Chrome
- Dropbox
- OneDrive
- WhatsApp
- Skype
- Grammarly Desktop

**App Store Apps:**
All these could have been installed via `brew`. I did it manually though.
- Kindle
- GarageBand
- iMovie
- Xcode
- PasteBox
- Magnet
- Unsplash Wallpapers

## Install XCode Command Line Tools

```bash
xcode-select --install
xcode-select -p
```

## Install Developer Fonts

- Copy fonts from `~/Dropbox/workspace/cloud-configurations/fonts/*` to `~/Library/Fonts`

## Notes: Keyboard
- English
- Hindi Transliteration

## Brew related note
- When you install `brew` on M1/M2, it gets installed at `/opt/homebrew`. This is a HUGE change that will affect a lot of things, some of which are called out below
  + .zshrc
  + macos-plugin.zsh
  + gpg-agent.conf
- `brew`
  + Use `Brewfile` stored in `~/Dropbox/workspace/cloud-configurations/brew/Brewfile`. The file was created using `brew bundle dump` followed by `brew bundle install --file <path-to-Brewfile>`

## Cisco Software

**Cisco-centric software and configurations (Automatically installed):**
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
- Sublime Text (Needs license..Evernote)
- SnagIt (Needs license..Login)
- DaisyDisk (Needs license..Gmail or Evernote)
- Kaleidoscope (Needs licese..Gmail or Evernote)

**My Development UI Software:**
- iTerm2
- VSCode
- VirtualBox
- Transmit (Needs license..Gmail and Evernote had it. It was forcing me to go to Subscription though.)
  + Had to import the 3 servers with secrets from `~/Dropbox/workspace/cloud-configurations/transmit`
  + Used encryption key stored in Evernote
- Jetbrains Toolbox
- Docker Desktop

**UI App Needing Custom configurations:**
- iTerm2
  - [Sync your iTerm2 Settings and Configs between devices](https://shyr.io/blog/sync-iterm2-configs)
- VS Code
  - Settings got synced once I logged into GitHub, but projects did not
- Sublime Text
  - Sublime Text had to be configured manually
    + `sudo ln -s '/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl' subl`
    + Copied and pasted the config using Gmail. Gist was updated as well...
    + Installed DankNeon and ProjectManager plugins manually
- vim
  + Install Vundle
  + Run `:PluginInstall` after installing `Vundle`
- neovim
  + Read the `nvim` documentation. Steps are captured in details

## Grunt Work
- All softlinks listed below had to be setup manually on the new laptop
  - `.aws -> /Users/anasharm/Dropbox/workspace/cloud-configurations/aws`
  - `.azure -> /Users/anasharm/Dropbox/workspace/cloud-configurations/azure`
  - `.cargo` (list of binaries)
  - `.codectl.yaml -> /Users/anasharm/Dropbox/workspace/cloud-configurations/.config`
  - `.config/gcloud` -> `/Users/anasharm/Dropbox/workspace/cloud-configurations/gcloud`
  - `.config/gh` -> `/Users/anasharm/Dropbox/workspace/cloud-configurations/gh`
  - `.config/iterm2` -> `/Users/anasharm/Dropbox/workspace/cloud-configurations/iterm2`
  - `.config/nvim` -> `/Users/anasharm/Dropbox/workspace/cloud-configurations/nvim`
  - `.config/pgcli` -> `/Users/anasharm/Dropbox/workspace/cloud-configurations/pgcli`
  - `.config/starship.toml` -> `/Users/anasharm/Dropbox/workspace/cloud-configurations/starship/starship.toml`
  - `.config/topgrade.toml` -> `/Users/anasharm/Dropbox/workspace/cloud-configurations/topgrade/topgrade.toml`
  - `.dotfiles` (from personal GitHub)
  - `.kube` -> `.dotkube` (from personal GitHub)
  - `.gitconfig` -> `/Users/anasharm/.dotfiles/git/gitconfig`
  - `.gitignore_global` -> `/Users/anasharm/.dotfiles/git/gitignore_global`
  - `.gnupg` -> `/Users/anasharm/Dropbox/workspace/cloud-configurations/gnupg`
  - `.jfrog` -> `/Users/anasharm/Dropbox/workspace/cloud-configurations/jfrog`
  - `.ldaprc` -> `/Users/anasharm/.dotfiles/ldap/ldaprc`
  - `.pgpass` -> `/Users/anasharm/Dropbox/workspace/cloud-configurations/psql/pgpass`
  - `.ssh` -> `/Users/anasharm/Dropbox/workspace/cloud-configurations/ssh`
  - `.ticker.yaml` -> `/Users/anasharm/Dropbox/workspace/cloud-configurations/ticker/ticker.yaml`
  - `.tijori` -> `workspace/cloud-configurations/tijori/all.sh`
  - `.tmux.conf` -> `/Users/anasharm/.dotfiles/tmux/tmux.conf`
  - `.tmux.conf.local` -> `/Users/anasharm/.dotfiles/tmux/tmux.conf.local`
  - `.vim` -> `/Users/anasharm/.dotfiles/vim`
  - `.vimrc` -> `/Users/anasharm/.dotfiles/vim/vimrc`
  - `.wrangler` -> `/Users/anasharm/Dropbox/workspace/cloud-configurations/wrangler`
  - `.zshrc -> /Users/anasharm/.dotfiles/zsh/zshrc`
  - `.zsh_history`
    + Merge history from old to new using these commands [Source](https://gist.github.com/calexandre/63547c8dd0e08bf693d298c503e20aab)
  ```bash
    builtin fc -R -I "$hist_file"
    builtin fc -R -I "$another_hist_file"

    # write the loaded history to HISTFILE
    builtin fc -W "$HISTFILE"
  ```
- `sfdx` CLI had to be installed manually using `Pkg` file from their [site](https://developer.salesforce.com/tools/sfdxcli)
  -`sfdx` plugin for Copado is also manually installed using `sfdx plugins:install @copado/copado-cli`
  - Authenticate to all the orgs..
    + `sfdx auth:web:login -a cop -r https://ciscodeploy.my.salesforce.com`
    + `sfdx auth:web:login -a cop-stg -r https://ciscodeploy--stage.sandbox.my.salesforce.com`
    + `sfdx auth:web:login -a cop-upgpoc -r https://ciscodeploy--upgradepoc.sandbox.my.salesforce.com`
    + `sfdx auth:web:login -a cop-upgqa -r https://ciscodeploy--upgradeqa.sandbox.my.salesforce.com`
    + `sfdx auth:web:login -a cop-upgstg -r https://ciscodeploy--upgradestg.sandbox.my.salesforce.com`
    + `sfdx auth:web:login -a cpdev -r https://ciscodeploy--cpdev.sandbox.my.salesforce.com`
    + `sfdx auth:web:login -a cpqa -r https://ciscodeploy--cpqa.sandbox.my.salesforce.com`
    + `sfdx auth:web:login -a cpprd -r https://ciscodeploy--cpprd.sandbox.my.salesforce.com`
    + `sfdx auth:web:login -a rc-devpro01rc -r https://ciscorevenuecloud--devpro01rc.sandbox.my.salesforce.com`
    + `sfdx auth:web:login -a rc-dv1rc -r https://ciscorevenuecloud--dv1rc.sandbox.my.salesforce.com`
    + `sfdx auth:web:login -a seaz`
    + `sfdx auth:web:login -a seaz1`
    + `sfdx auth:web:login -a seaz2`
    + `sfdx auth:web:login -a sm-sandbox -r https://ciscosales--anasharm.sandbox.my.salesforce.com`
- `rustup` had to be installed manually using shell script listed on the [site](https://www.rust-lang.org/tools/install)
```bash 
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```
- `wasmtime` had to be installed manually using shell script listed on the [site](https://wasmtime.dev/)
```bash
curl https://wasmtime.dev/install.sh -sSf | bash
``` 
- `wasmer` had to be installed manually using shell script listed on the [site](https://wasmer.io/)
```bash
curl https://get.wasmer.io -sSfL | sh
``` 
- `bun` had to be downloaded from [bun.sh](https://bun.sh)
- `aws` CLI had to be downloaded as it did not come with brew ([Source](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html))
```bash
curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
sudo installer -pkg AWSCLIV2.pkg -target /
```
- `gpg` configuration did not work because `gpg-agent.conf` was pointing to the wrong absolute path for `pinentry-mac`. Had to update the path, `killall gpg-agent` and restart the terminal for `git commit` to work
- Node `npm` modules were moved manually from one laptop to another
```bash
npm list -g --depth=0
/opt/homebrew/lib
├── git-stats@3.1.1
├── npm@9.1.2
└── wrangler@2.5.0
```
- `cargo` installs were moved manually from one laptop to another
```bash
cargo install --list
bottom v0.6.8:
    btm
cargo-update v11.1.0:
    cargo-install-update
    cargo-install-update-config
htmlq v0.4.0:
    htmlq
miniserve v0.22.0:
    miniserve
tidy-viewer v1.4.30:
    tidy-viewer
```
- `pip` modules were moved programmatically
```bash
# Source laptop
p -m pip freeze > ~/Dropbox/workspace/cloud-configurations/python-modules.txt
# Destination laptop
p -m pip install -r ~/Dropbox/workspace/cloud-configurations/python-modules.txt -U
```
- `go` modules were installed manually