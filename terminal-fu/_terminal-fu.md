# terminal-fu scratchpad

#### Numer of files in any folder

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

#### Show hidden files in File Open Dialog:
`Cmd + Shift + .`

#### chflags

```bash
chflags nohidden ~/Library/
chflags hidden ~/Library/
```





