# intellij idea

## Turn Noise Off

Remove distractions by going to **Main Menu | View | Appearance** and uncheck toolbar, tool window bar, navigation bar. What’s left are tabs. Please get rid of them by right-click into the tab and choose **Configure Editor Tabs…** and on the appearance section, set tab placement to None.

- `Cmd + Shift + P` (or A) => Breadcrumbs (Off)
- `Cmd + Shift + P` (or A) => Navigation (Off)
- `Cmd + Shift + P` (or A) => Editor Preferences | Tabs Placement (None)

## Custom Installed Plugins

- Active Tab Highlighter Plugin
- ## IntelliJ light theme
- .ignore
- BashSupport
- Makefile support
- Rainbow Brackets
- Presentation Assistant

## Custom Preferences

- Editor | General | Editor Tabs
  - Mark modified tabs
- Editor | Inlay Hints
  - Parameter Hints - Turn it on
- Active Tab Color
  - Set it to  #D0FF49 (for Dracula, 0D6215 | AE0F0F | 7E2D9B)
- Code Style | Kotlin | Code Generation + Comment Code
  - Uncheck “Line Comment at first column"
  - Check "Add Space at comment start"
  - Uncheck “Block comment at first column"
- Open a sample source code. Hover over a function call. The Documentation Tool tip opens. Adjust the font and display size.
  - Editor | General | Code Folding
- Uncheck File Header
- Uncheck Imports
- Uncheck One-line methods
  - Editor | General | Soft Wraps
- Check Soft Wrap these Files
  - `Cmd + 2` => Map it to Tool Windows | Database (from Tool Windows | Favorites)
  - `Cmd + 6` => Map it to Tool Windows | Terminal (from Tool Windows | Problems)

## Keyboard Shortcuts: Get Going

- `Shift + Cmd + W` => Close Project ✅
- `Alt + -` => Hide All Tool Windows ✅
- `Ctrl + Alt + N` => Create New… ✅
- `Cmd + <Up Arrow>` => Jump to Navigation Bar... ✅
- `Cmd + Shift + N` => New Scratch File
- `Cmd + Shift + Return` => Complete Current Statement ✅
- `Alt + Return` => Show Context Actions ✅
- `Ctrl + Shift + R` => Run Context Configuration from the Editor… ✅
- `Ctrl + Shift + D` => Debug Context Configuration from the Editor…
- `Alt + Space` => Quick Definition
- `Ctrl + J` => Quick Documentation ✅

## Keyboard Shortcuts: Writing/Editing Code

- `Alt + F` => Navigate File Structure
- `Alt + Cmd + L` => Format Code ✅
- `Cmd + N` => Generate Code ❗
- `Ctrl + O` => Override Methods ✅
- `Alt + Ctrl + O` => Optimize Imports
- `Alt + Cmd + T` => To surround existing code with stuff… ✅
- `Cmd + Shift + +` => Expand all Code
- `Cmd + Shift + -` => Fold all Code
- `Cmd + -` => Fold the function you are in
- `Cmd + +` => Expand the function you are in
- `Editor Actions | Split Line` (Remove Keyboard shortcut)
- `Cmd + Return` => Editor Actions | Start New Line ✅
- `Shift + Cmd + Return` => Editor Actions | Start New Line Before Current ✅
- `Shift + Cmd + D` => Editor Actions | Duplicate Line
- `Shift + Cmd + K` => Editor Actions | Delete Line
- `Ctrl + G` => Go to Line
- `Alt + Select Column` => Multi-Column selection
  - In VS Code, it is `Shift + Alt + Select Column`
- `Shift + Alt + Click(s)` => To create multiple cursors
  - In VS Code, it is `Alt + Click(s)`
- `Alt + V` => Vim Emulator Enable/Disable Toggle
- `Shift + Cmd + '` => Maximize Tool Window
- `Alt + O` (alphabet O) => Open the Recent Projects Window... ✅
- `Alt + 0` (number Zero) => Open...
- `Ctrl + Cmd + F` => Presentation Mode
- `Ctrl + Alt + H` => Call Hierarchy (Trace the method calls that led to the current method being invoked)

## Keyboard Shortcuts: Commenting Code

- `Cmd + /` => Comment Code ✅
- `Alt + Cmd + /` => Comment Code (using Block Comments) ✅

## Keyboard Shortcuts: Build Interactions

- `Alt + C` => Build the selected file...
- `Cmd + Shift + I` (as in alphabet i) => Reload Gradle Project... ✅
- `Ctrl + Ctrl` => Run anything from anywhere...

## Keyboard Shortcuts: SCM Interactions

- `Alt + 1` => Bring up the Branches Window
- `Alt + Cmd + H` => Share on GitHub ❗
- `Ctrl + V` => Add Project to Git
- `Cmd + K` => Commit (Also brings up the Commit Window) ✅
- `Alt + Cmd + K` => Commit & Push ✅
- `Cmd + Enter` => Submit Changes across the Git Experience ✅

## Keyboard Shortcuts: Refactoring

- `Ctrl + T` => Refactoring Menu showing all options. Use number next to the option to navigate quickly ❗
- `Alt + R` => Rename
- `Alt + Cmd + M` => Introduce Method
- `Alt + Cmd + V` => Introduce Variable
- `Alt + Cmd + C` => Introduce Constant
- `Alt + Cmd + P` => Introduce Parameter

## Keyboard Shortcuts: Finding

- `Cmd + F` => Find… ✅
- `Shift + Cmd + F` => Find in Files inside the opened Project
- `Shift + Cmd + R` => Replace in Files inside the opened Project
- `Alt + Cmd + F` => Replace ✅
- `Cmd + E` => Recent Files ✅
- `Shift + Cmd + P` => Find Actions (Sublime Text and/or VS Code) ✅

## Keyboard Shortcuts: Navigating Around

- [IntelliJ Docs: Source code navigation](https://www.jetbrains.com/help/idea/navigating-through-the-source-code.html)
- `Cmd + P` => Navigate to File ✅
- `Cmd + O` => Navigate to Types
- `Alt + Cmd + O` => Navigate to Symbol
- `Ctrl + `` => Terminal ✅
- `Cmd + 1` => Project Window ✅
- `Cmd + 2` => Favorites Window
- `Alt + _` => Hide Tool Window ✅
- `Cmd + ,` => Open Preferences ✅
- `Cmd + ;` => Open Project Settings ✅
- `Cmd + [` => Navigating backwards between files
- `Cmd + ]` => Navigating forward between files
- `Cmd + Shift + T`  => Navigate between the Test and the thing you are Testing. Or, to switch back from test method to actual method in the Class being - tested
- `Cmd + B` => Go to Declarations. For example, pressing this on a field will take the cursor to the field declaration. Pressing it on a class name will take us to the class file.
- `Alt + Cmd + B` => Navigate to the implementation (of a function, for example)

## Keyboard Shortcuts: Select for Copy/Paste

- `Alt + Up Arrow` => To gradually increase the contextual selection block ✅
- `Alt + Down Arrow` => To gradually decrease the contextual selection block ✅
- `Cmd + L` => Select Line under Caret ✅
- `Cmd + D` => Editor Actions | Add Selection for Next occurrence ✅
- `Cmd + G` => Find Next Occurrence
- `Cmd + Shift + G` => Find Previous Occurrence
- `Ctrl + Cmd + G` => Editor | Select all Occurences

## Keyboard Shortcuts: Live Templates

- `psvm` or `main`
- `sout`, `souf`
- `iter`, `itar`
- `sysout` => Eclipse shortcut for sout
- `giti` => Git Ignore
