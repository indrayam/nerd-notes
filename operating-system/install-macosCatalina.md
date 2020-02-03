# Install MacOS (Catalina)

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
- Setup Siri
- Setup TouchID

### Setup ComputerName

```bash
sudo scutil --set HostName macbook16.local
sudo scutil --set ComputerName macbook16
dscacheutil --flushcache
```

### Install XCode Command Line Tools

```bash
xcode-select --install
xcode-select -p
```

### Install Microsoft Office

- Log into www.office.com with your personal email id
- Download ~1.6 GB worth of downloads
- Install and configure Outlook, PowerPoint, Excel and OneNote

### Install JetBrains Mono Font

### Install Homebrew Cask Formulas

Source: [Homebrew.sh Formulas](https://formulae.brew.sh/cask/)

```bash
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew tap homebrew/cask-fonts
brew update
brew cask install iterm2
```

### Configure iTerm2
- Run iTerm2
- Changes in `Preferences | Appearance`
    + Check `Show tab bar even when there is only one tab`
    + Select `Dark` Theme
- Changes in `Preferences | Profiles | Text`
    + Set `Vertical Bar`
    + Change Font to `JetBrains Mono 22`, Check `Use Ligatures`
- Changes in `Preferences | Profiles | Window`
    + Select `Background Image`. Select the image from Dropbox zz_miscellaneous/ folder (`BlackHole..`)
    + Columns `450 x 150`
- Changes in `Preferences | Profiles | Terminal`
    + Check `Unlimited Scrollback`

### Install Homebrew Cask Formulas

Source: [Homebrew.sh Formulas](https://formulae.brew.sh/cask/)

```bash
brew cask install google-chrome firefox evernote dropbox font-fira-code java osxfuse visual-studio-code sublime-text snagit jetbrains-toolbox microsoft-edge virtualbox vmware-fusion robo-3t postman tableplus webex-meetings webex-teams zoomus slack telegram wechat whatsapp skype multipass 
brew install mas # interact with AppleStore Apps
```

- Use my "vault" to update licenses for Sublime Text. For Snagit, just log into Snagit site
- Get VMWare Fusion Professional license from "vault"
- Postman is driven by Google Account

### Install AppStore Apps

```bash
mas search Media
mas install 1063631769
mas search Xcode
mas install 497799835
mas search Things
mas install 904280696
mas search kindle
mas install 405399194
```

I had to install Dato manually :-). Configure Dato to add Date, Week Number and Time Zones as needed.

### Install Jetbrains Apps

- Open Jetbrains Toolbox
- Download
    + IntelliJ IDEA Ultimate 
    + PyCharm Professional 
    + GoLand 

### Install VS Code Plugins

- Run the command from this [gist](https://gist.github.com/indrayam/df2bf10402cc53527386ecf224d38728)

### Install Homebrew CLI Forumulas

Refer to the `brew-install.sh` script in `Dropbox/` under `workspace/brew`


### Configure Sublime Text 3

Install Package Control Plugin in Sublime Text 3 by selecting "Tools | Install Package Control"

Go to `Sublime Text | Preferences | Package Settings | Package Control | Settings - User`. Append the following entries to the file. Refer to this [gist](https://gist.github.com/indrayam/eac5dc48a701d71d142063f13d269269) for latest values of installed packages:

```bash
    "in_process_packages":
    [
    ],
    "installed_packages":
    [
        "A File Icon",
        "AdvancedNewFile",
        "Alignment",
        "AlignTab",
        "All Autocomplete",
        "BracketHighlighter",
        "Console Wrap",
        "CSS3",
        "Emmet",
        "GitGutter",
        "GitSavvy",
        "Increment Selection",
        "Julia",
        "Kotlin",
        "MagicPython",
        "Markdown Extended",
        "Material Theme",
        "Materialize",
        "Package Control",
        "PackageResourceViewer",
        "ProjectManager",
        "SideBarEnhancements",
        "Sublime Tutor",
        "Text Pastry",
        "Theme - Spacegray"
    ]
```

After adding the packages you want to on Package Control.sublime-settings, just restart Sublime Text and the Package Control will start installing those packages. Open console window (`Ctrl+^`) immediately after restart to see activities.

Once all the installation is complete, copy the Sublime Text 3 settings from this [gist](https://gist.github.com/indrayam/41fc917003231f528765406cdca6aab3)

Copy the latest `Projects` folder from your existing Mac's Sublime Text (`Browse Packages | User`) or get it from `Dropbox | workspace | macos`

Finally, update GitSavvy settings as below:

```bash
{
    "git_path": "/usr/local/bin/git",
    "api_tokens": {
        "github.com": "..."
    },
    "show_panel_for": ["pull", "push"],
    "sort_by_recent_in_branch_dashboard": true,
    "show_remotes_in_branch_dashboard": true,
}
```



### Configure VS Code
- Install the VS Code Plugins be using the script in this [gist](https://gist.github.com/indrayam/df2bf10402cc53527386ecf224d38728)
- Configure the settings by pasting the latest configuration stored in this [gist](https://gist.github.com/indrayam/94bc32e093000a45fb653a6bf9e32cfc)
- Copy the Project Manager's JSON file over

### Configure the Zsh
- Install oh-my-zsh
- Copy the SSH dotfiles from the "vault"
- Clone the .dotfiles repo into ~/.dotfiles
- Run setup-symlinks-macosx.sh

### Install Python Libs

- For `python2`, assuming it is still relavant, just run `pip2 install python-openstackclient`. That should be good enough
- For `python3`, just run `pip2 install requests csvkit`. That should be good enough to start off with
- Install AWS CLI v2

```bash
curl "https://d1vvhvl2y92vvt.cloudfront.net/awscli-exe-macos.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
```

### Install Node Modules

- Run `npm ls -g --depth=0` on one machine
- Manually run each on the other machine.

I do understand [automations](https://stackoverflow.com/questions/32628351/export-import-npm-global-packages) exist. But I ran into some errors, so did not want to take any chances...

- `npm ls -g --depth=0 > ~/Dropbox/workspace/...`
- `npm update -g`

### Install Krew Plugins

```bash
(
  set -x; cd "$(mktemp -d)" &&
  curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/download/v0.3.3/krew.{tar.gz,yaml}" &&
  tar zxvf krew.tar.gz &&
  KREW=./krew-"$(uname | tr '[:upper:]' '[:lower:]')_amd64" &&
  "$KREW" install --manifest=krew.yaml --archive=krew.tar.gz &&
  "$KREW" update
)
```

- Run `krew-plugins.sh` from `Dropbox | workspace | macos-setup`

### Dock Sequence

- Finder
- AppStore
- System Preferences
- Launchpad
- EverNote
- Things
- VMWare Fusion
- VirtualBox
- Books
- Amazon Kindle
- iTerm2
- Visual Studio Code
- Sublime Text 3
- SnagIt
- JetBrains Toolbox
- IntelliJ IDEA
- GoLand
- PyCharm
- XCode
- Kaleidoscope
- Medis
- Postman
- TablePlus
- Robo 3T
- Google Chrome
- Firefox
- Safari
- Microsoft Edge
- Microsoft Outlook
- Microsoft PowerPoint
- Microsoft Excel
- Microsoft OneNote
- Apple FaceTime
- Cisco Webex Teams
- Slack
- WhatsApp
- WeChat
- Telegram
- Skype
- Apple iMessages
- Apple Music
- Apple Podcasts
- Calculator
- Daisy Disk
- Activity Monitor (showing CPU)

