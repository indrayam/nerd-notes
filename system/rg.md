# rg

Source: 
- [Fast Searching with ripgrep](https://mariusschulz.com/blog/fast-searching-with-ripgrep)
- [ripgrep Cheatsheet](https://skerritt.blog/ripgrep-cheatsheet/)
- [How to Use the Fast and Powerful ripgrep Command-Line Tool](https://gcore.com/learning/use-ripgrep-command-line-tool/)

## Useful Commands

```bash
# rg commands
rg <pattern> <dir> # Searches for pattern in dir
rg '// TODO'
rg -l '// TODO' --sort path
rg -i <pattern> <dir> # Case insensitive search
rg "hello" -B 1 -A 1 # Shows 1 line before and after the match
rg "hello" -A 1 # Shows 1 line after the match
rg "hello" -C 1 # Shows 1 line before and after the match
rg --files | rg cluster # Searches for cluster in all files
rg crypto -g '!modules/' -g '!pypi/' # Excludes modules and pypi folders
# Example: rg -t py transformer # Searches for transformer in python files
rg -t <file-type> <pattern> <dir> # Searches for pattern in files of type file-type

rg local/bin -g '/.*' --max-depth 1

# ag commands
ag -l --xml "<project>|</maven2-moduleset>"
ag -ig <file-name> <dir-name> # If no dir-name, it starts in current dir. Use .agignore to ignore folders
ag -i <search-term> <dir-name> #Searches for text inside file
```

