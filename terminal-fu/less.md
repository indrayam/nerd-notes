# less (or more)

## Basics
- `command | less` To invoke less
- `:f` to scroll forward
- `:Nf` will scroll forward `N` lines
- `:Space` to scroll forward
- `:b` to scroll backward
- `:Nb` will scroll backward `N` lines
- `:q` to quit

## Issue

The command `tree . | more` was messing up the output with lots of ANSI color escape sequences like `ESC [ ... m`. To solve this, you need to do run:

```bash
tree . | more -R
# OR (Note: less did not need a -R as it was working fine without it)
tree . | less -R
```

Source: [How can I pipe colored tree result to less or more?](https://unix.stackexchange.com/a/90295/30929)
