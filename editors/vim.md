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

**How do you know which buffer is active?**

Look at the airline status line. The one with the cursor will be highlighted




