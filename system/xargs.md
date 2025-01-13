# xargs

## Useful commands

```bash
find py -type d -name .venv -print0 | xargs -0 -I {} /bin/rm -rf "{}"

```

- `-print0` : Show the full file name on the standard output, followed by a null character. This allows file names that contain newlines or other types of white space to be correctly interpreted by programs that process the find output. This option corresponds to the -0 option of xargs

- `-0` : Input items given by find are terminated by a null character instead of by whitespace, and the quotes and backslash are not special (every character is taken literally). Disables the end of file string, which is treated like any other argument. Useful when input items might contain white space, quote marks, or backslashes. The GNU find `-print0` option produces input suitable for this mode.

- `-I {}` : `{}` in the initial-arguments with names read from standard input. For example, dir names given by find command

- `/bin/rm -rf "{}"` : Run rm command that remove files or directories passed by `{}`
