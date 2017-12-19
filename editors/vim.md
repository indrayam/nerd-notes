# vim

### How to use "sudo vim" correctly?

```bash
# sudo vim command does not use the user's vimrc. To fix that, do the following
export EDITOR=vim # If it is not already set
sudoedit <filename>
```

### Toggle Hybrid line numbers 
[Source](https://jeffkreeftmeijer.com/vim-number/)

`:set number relativenumber`
`:set nonumber norelativenumber`

### If you need to force a screen redraw
`:redraw!`



