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
