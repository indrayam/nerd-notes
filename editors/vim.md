# vim

## How to use "sudo vim" correctly?

```bash
# sudo vim command does not use the user's vimrc. To fix that, do the following
export EDITOR=vim # If it is not already set
sudoedit <filename>
```

## Toggle Hybrid line numbers

[Source](https://jeffkreeftmeijer.com/vim-number/)

`:set number relativenumber`
`:set nonumber norelativenumber`

## If you need to force a screen redraw

`:redraw!`

## Dealing with Buffers

```bash
edit [file] # open a new buffer
bn # go to the next buffer
bp # go the previous buffer
bd # delete buffer
```

## Dealing with Splits

```bash
vsp [filename] # vertical split
sp [filename] # horizontal split
close # close the split
Ctrl + j # Move cursor to the split below
Ctrl + k # Move cursor to the split above
#...
```

**How do you know which buffer is active?** Look at the airline status line. The one with the cursor will be highlighted

More split goodness below...

```
"Max out the height of the current split
ctrl + w _

"Max out the width of the current split
ctrl + w |

"Normalize all split sizes, which is very handy when resizing terminal
ctrl + w =

"Swap top/bottom or left/right split
Ctrl+W R
```

Source: [Vim Splits - Move Faster and More Naturally](https://thoughtbot.com/blog/vim-splits-move-faster-and-more-naturally)

## Dealing with Multiple Files

```bash
cd <project-folder>
vim **/.java (or **/.py)
:ls
:bn
:bp
:bd!
:b10
```

## Dealing with Sessions

```bash
:mks ~/.vim-sessions/<project-name>.vim
:source ~/.vim-sessions/<project-name>.vim
# or
vim -S ~/.vim-sessions/<project-name>.vim
```

That said, vim-obsession plugin is far too cool. Here's what you do:

```bash
:Obsess
# This will automatically start tracking your sessions. When you quit, it will save things in a file called Sessions.vim
:Obsess!
# If you want to stop tracking and delete the Sessions.vim file
```

## Searching across files

```bash
<c-p> to bring up CtrlP
<c-f> and <c-b> to cycle between modes
<c-d> to switch to filename search instead of full path
```
