# terminal-fu scratchpad

### Numer of files in any folder

```bash
cd <folder>
for t in files links directories; do echo `find . -type ${t:0:1} | wc -l` $t; done 2> /dev/null
```

Sample Output:

```bash
     7 files
     0 links
     9 directories
```

### Show hidden files in File Open Dialog:
`Cmd + Shift + .`

### chflags

```bash
chflags nohidden ~/Library/
chflags hidden ~/Library/
```

### Command-line shortcuts

- `Ctrl-r` Search through command-line history. Hit enter when you find the command
- `!ssh` will run the last ssh command you used
- `history|awk '{print $2}'|awk 'BEGIN {FS="|"} {print $1}'|sort|uniq -c|sort -r|less` to show which commands you use the most
- `Ctrl-a` Go to the beginning
- `Ctrl-e` Go to the end
- `Ctrl-u` Delete the entire line
- `Ctrl-w` Delete the word on the line
- `Esc-.` Repeat only the last argument of the previous command




