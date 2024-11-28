# man

### man basics
`man 1 whoami`: The `1` is the section number
`man -a lvcreate`: The `-a` means show manual pages for the command from all 4 sections
`man -k <word>`: Use this to search for commands that have the <word> in the actual command or description. An alias for `man -k` command is the `apropos` command. It's an alias for `man -k`

### man sections
- **1**: User Commands
- **4**: Device Commands
- **6**: Configuration Files
- **8**: Administration Commands

`^F` to move forward one window at a time inside a man page entry, while `^B` allows you to move back one window at a time

`j` can be used to move down a line, while `k` can be used to move up a line.

`G` to go to the very end of the man page entry, while `gg` or `g` will take you to the very top

`/EXAMPLE` will perform search of the manual.

### mandb
`sudo mandb` will regenerate the man database for `man -k` commands to work


