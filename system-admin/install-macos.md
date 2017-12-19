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
    Set `Vertical Bar`
    Change Font to `Fira Code 19`, Check `Use Ligatures`
- Changes in `Preferences | Profiles | Window`
    Download [background image](https://s3.amazonaws.com/us-east-1-anand-files/media-files/milkyway-iterm2-background.jpg) in `Downloads/` folder
    Select `Background Image`. Select the download image from `Downloads/` folder
    Columns `450 x 150`
- Changes in `Preferences | Profiles | Terminal`
    Check `Unlimited Scrollback`
