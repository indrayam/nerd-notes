# Setting up a brand new MacBook

### Power up and the basics
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

### Install OS Updates and 
- Open App Store and start updating softwares, if any
- Add Terminal App from *"Applications > Utility > Terminal"* to the Dock
- Run the following command to install XCode and the command line tools:
    `> xcode-select --install`
- Select "Get XCode"
- Once everything is installed, run 'XCode' and Accept the License. This will also trigger installation of components
- Open the terminal and run the following to install the command-line utilities
    `> xcode-select --install`

### Change the default settings for Finder, Terminal and TextEdit
- Open Finder | Preferences
    In Sidebar, add "anasharm"
    In General, add "Hard Disks"
    New Finder windows show: "anasharm"
- Change the Finder "Favorites" list to follow this pattern
    All My Files
    Air Drop
    Applications
- Open Terminal | Preferences | Font
    Set the size to 14
- Open TextEdit Preferences
    New Document should default to "Plain Text"
    Uncheck every single textbox in the Options 
    Change the default "Plain text font" and "Rich text font" size to 14

### Install Homebrew (brew and brew cask)

```bash
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew tap caskroom/fonts
brew cask install google-chrome firefox evernote dropbox font-fira-code java osxfuse shiftit iterm2
brew install ack automake colordiff doctl git gnu-tar gzip jq openssl sqlite bash coreutils gnupg htop-osx multitail openssl@1.1 ssh-copy-id tmux xz ansible git-extras httpie neovim go python python3 perl ruby sshfs tree apr bison curl findutils glib pcre readline apr-util diff-so-fancy gawk gmp gradle icu4c vim cloc gdbm gnu-indent grep watch autoconf gettext gnu-sed s3cmd the_silver_searcher wget
```

### Configure iTerm2
- Run iTerm2
- Changes in `Preferences | Appearance`
    + Check `Show tab bar even when there is only one tab`
    + Select `Dark` Theme
- Changes in `Preferences | Profiles | Text`
    + Set `Vertical Bar`
    + Change Font to `Fira Code 19`, Check `Use Ligatures`
- Changes in `Preferences | Profiles | Window`
    + Download [background image](https://s3.amazonaws.com/us-east-1-anand-files/media-files/milkyway-iterm2-background.jpg) in `Downloads/` folder
    + Select `Background Image`. Select the download image from `Downloads/` folder
    + Columns `450 x 150`
- Changes in `Preferences | Profiles | Terminal`
    + Check `Unlimited Scrollback`

### oh-my-zsh
- Install oh-my-zsh:
    + `sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"`
- Quit `iTerm2` and restart

### Custom ".dotfiles"

```bash
cp ~/Dropbox/sec/dotssh/id_rsa* ~/.ssh
chmod 400 ~/.ssh/id_rsa
git clone git@github.com:indrayam/dotfiles.git .dotfiles
cd .dotfiles
./setup-symlinks-macosx.sh
cd
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
vim # Test the installation of the Vim plugins
```

### Google Cloud SDK

```bash
curl -L -O "https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-182.0.0-darwin-x86_64.tar.gz"
tar -xvzf google-cloud-sdk-182.0.0-darwin-x86_64.tar.gz
mv google-cloud-sdk /usr/local
```

### ShiftIt
- Open ShiftIt. It will prompt to set `System Preferences | Privacy | Accessibility`. Set it. 
- Start it up again. Make it Recheck. Set it to launch on Startup

### Dropbox
- Run Dropbox. Log in. Configure folders to sync

### Chrome
- Run Chrome. Log in. Update your passphrase.
- Install the following extensions:
    + Google Mail Checker
    + OneTab

### Evernote
- Run Evernote. Log in. Enter your 2FA. Select "Snippet View"

### Snagit
- Go to [techsmith.com](http://techsmith.com). Log in. Go to My Products. 
- Start Download of "Snagit 2018"
- Run `snagit.dmg`
- Drag `SnagIt` to `/Applications`
- Open `SnagIt`
- Log in to unlock `Snagit`
- Run `Snagit`
- Changes in `Preferences | General`
    + Check `Always Keep Snagit Running in Background`
    + Set `Editor Color Theme` to "Dark"
- Changes in `Preferences | Scrolling Capture`
    + Enable it
    + Install "System Audio" component
    + Remove all keyboard shortcuts, except for "All-in-One Capture"

### Tower (Git Client)
- Download [Tower](http://www.git-tower.com/download)
- Unzip. Drag the app to `/Applications`

### Sublime Text 3
- Download [Sublime Text](https://www.sublimetext.com/)
- Install it
- Run it
- Install License

### Sublime Text 3 Plugins
- Go to `Tools | Install Package Control...`
- Select `Preferences` and add the entry in this [gist](https://gist.github.com/indrayam/b962862ac77a15298a38ad3f7d8a69ad)
- Installed the following plugins:
    + A File Icon
    + AdvancedNewFile
    + Alignment
    + AlignTab
    + All Autocomplete
    + BracketHighlighter
    + Console Wrap
    + CSS3
    + Emmet
    + GitGutter
    + GitSavvy
    + Increment Selection
    + MagicPython
    + Markdown Extended
    + Material Theme
    + PackageResourceViewer
    + Project Manager
    + PyV8
    + Sublime Tutor

### Unsplash Desktop
- Download it from Mac Store

### Calendar 2
- Download it from Mac Store

