# vim

### How to use "sudo vim" correctly?

```bash
# sudo vim command does not use the user's vimrc. To fix that, do the following
export EDITOR=vim # If it is not already set
sudoedit <filename>
```

