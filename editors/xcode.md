# xcode

#### Keyboard Shortcuts

```bash
Ctrl + I (Re-indent)
Cmd + Option + W (Close Project)
Cmd + Shift + N (New Project)
```

#### Xcode CmdLine

[https://developer.apple.com/library/mac/technotes/tn2339/_index.html#//apple_ref/doc/uid/DTS40014588](https://developer.apple.com/library/mac/technotes/tn2339/_index.html#//apple_ref/doc/uid/DTS40014588)
- The Command Line Tools Package is a small self-contained package available for download separately from Xcode and that allows you to do command line development in OS X. It consists of two components: OS X SDK and command-line tools such as Clang, which are installed in /usr/bin
- How can I install them on my machine?

#### Using Xcode
If Xcode is installed on your machine, then there is no need to install them. Xcode comes bundled with all your command-line tools. OS X 10.9 includes shims or wrapper executables. These shims, installed in /usr/bin, can map any tool included in /usr/bin to the corresponding one inside Xcode. xcrun is one of such shims, which allows you to find or run any tool inside Xcode from the command line. Use it to invoke any tool within Xcode from the command line.

`$ xcrun dwarfdump --uuid  MySample.app/MySample`


#### Using the Terminal application
You can install them by running the `xcode-select --install` command or by attempting to use any other tool in Terminal


#### xcode-select
`xcode-select` Manages the active developer directory for Xcode and BSD tools ([Source](https://developer.apple.com/library/mac/documentation/Darwin/Reference/ManPages/man1/xcode-select.1.html))

`sudo xcode-select -switch /Applications/Xcode6-Beta.app`

OR

`sudo xcode-select -switch /Applications/Xcode.app`

`sudo xcode-select --print-path` To find out what version of Xcode is being used by your tools)

#### xcrun
`xcrun` Run or locate development tools and properties ([Source](https://developer.apple.com/library/mac/documentation/Darwin/Reference/ManPages/man1/xcrun.1.html#//apple_ref/doc/man/1/xcrun))

`xcrun --show-sdk-path --sdk macosx`
