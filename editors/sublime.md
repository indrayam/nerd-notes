# sublime text

## How do you make Sublime Text 3 open a file in a new tab instead of opening it in the current tab?

This is because you were only previewing the previous file. If you click on a file once in the sidebar, by default it opens in preview mode. Clicking another file will open it in preview mode, in the same tab.

In other words, single-clicking a file in the sidebar opens that file in preview mode, and single-clicking on another file replaces the first file with the second. If you want to keep a previewed file open, you need to double-click it, then the next single-clicked file will open in a new preview tab.

Source: [How do you make Sublime Text 3 open a file in a new tab instead of opening it in the current tab?](https://stackoverflow.com/questions/37765356/how-do-you-make-sublime-text-3-open-a-file-in-a-new-tab-instead-of-opening-it-in)

## How to fix color scheme to use better selection colors?

If you select a color scheme, and you actually do not like the way selecting text in the editor looks like, here's a color selection that works for me

- Open up Sublime Text preferences and see the current location of the color scheme that is in use
- Open the Color Scheme's `.tmTheme` file
- Search for `selection` and `selectionForeground`. Replace (or create) the following values:

```xml
    <key>selection</key>
    <string>#9D550F</string>
    <key>selectionForeground</key>
    <string>#fffff8</string>
```

- Save the file

## Keyboard Shortcuts

`Cmd + P`
Search files in the current project

`Cmd + C`
Copy

`Cmd + V`
Paste

`Cmd + Shift + V`
Paste and indent correctly

`Cmd + X`
Cut line

`Cmd + K, Cmd + K`
Delete to the end of the line

`Cmd + K, Cmd + Backspace`
Delete to the start of the line

`Cmd + Enter`
Insert line after

`Shift + Cmd + Enter`
Insert line before

`Cmd + L`
Select line

`Cmd + Shift + D`
Duplicate a line

`Cmd + Ctrl + Down Arrow`
Move line/selection down

`Cmd + Ctrl + Up Arrow`
Move line/selection up

`Cmd + J`
Join Selected Lines

`Cmd + ]`
Indent current line(s)

`Cmd + [`
Un-indent current line(s)

`Cmd + D`
Select word

`Cmd + Shift + [`
Cycle through Tabs (Going left)

`Cmd + Shift + ]`
Cycle through Tabs (Going right)

`Cmd + /`
Comment/Uncomment line(s)

`Option + Mouse Left Click`
Column Selection

`Ctrl + Shift + M`
Select inside the Bracket

`Cmd + Shift + H`
Format Code in the Buffer

`Ctrl + M`
Jump between matching brackets

`Cmd + Ctrl + i`
Plugin [Increment Selection](https://github.com/yulanggong/IncrementSelection)

`Cmd + Ctrl + a`
Plugin Alignment (Aligns nicely for = and :)

`Ctrl + Cmd + P`
List All Projects

`Ctrl + ``
Integrated (or External) Terminal

`Cmd K, Cmd B`
Toggle “Explore” View

## Plugin AlignTab (Alignment on Steroids)
`Shift + Cmd + P` Search for AlignTab, Select Live Preview or Table Mode

OR

Select text, right-click, select `Align By`..
this should handle most of the use cases
