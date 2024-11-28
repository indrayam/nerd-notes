# zsh

[Zsh Lovers](http://grml.org/zsh/zsh-lovers.html)

- Drop-in replacement for Bash
- Browse suggestions using arrow keys
- Complete commands by showing menu of relevant parameters
- Share history across sessions
    + Multiple simultaneously running zsh sessions can share history with each other. Type a few words and use 'Up' arrow
- Built in Pager
     less README or cat README
- Powerful Globbing
    + `ls **/*.png` Will automatically traverse all folders underneath "." and show png files
    + `ls stuff/**/*bar` Show me files ending with `bar` inside any/all subfolders of `stuff/`
    + `ls *.c` Show me files ending in .c
    + `ls *.[co]` Show me files ending in .c or .o
    + `ls *.[^co]` Show me files NOT ending in .c or .o
    + `setopt extended_glob`
        - `ls **/*.(sh|py)` Show me files under the current folder that ends in .sh or .py
        - `ls ^*.*` Show me files that do not end in `.suffix`
- Glob Qualifiers ([Source](http://zsh.sourceforge.net/Intro/intro_2.html ))
    + `ls *(.)` Match all files
    + `ls *(/)` Match all folders
    + `ls *(@)` Match all symbolic links
- Aliases:
    +`-='cd -'`
    +`..='cd ..'`
    +`...='cd ../..'`
    + `1='cd -'`
    + `dirs -v | head -10'`
    + `_=sudo`
    + `c=clear`
    + `cls=clear`
    + `cd..='cd ..'`
    + `cd...='cd ../..'`
    + `cd....='cd ../../..'`
    + `cd.....='cd ../../../..'`
- **STDERR** redirection: Use `2>`. For example: `find /proc -name "cpu*" 2> /dev/null`
- **STDIN** redirection: Use `<`. For example: `wc -l < /etc/group`
- **STDOUT** redirection: Use `>, >>`. For example: `echo "Hello, World!" > hello.txt`

## Auto Completion

```bash
echo $fpath
# This should show you all the folders where you can put Zsh auto-completion scripts. On a MacOSX, brew does a lot of the magic during the installation. It puts everything in /usr/local/share/zsh/site-functions
ls -al /usr/local/share/zsh/site-functions
# If you're not using Brew on MacOSX, here are the steps I followed. Taking kubectx as an example
cd $HOME/.oh-my-zsh/functions
cp $KUBECTX_INSTALL_FOLDER/completion/kubectx.zsh $HOME/.oh-my-zsh/functions/_kubectx
cp $KUBECTX_INSTALL_FOLDER/completion/kubens.zsh $HOME/.oh-my-zsh/functions/_kubens
source ~/.zshrc
compinit _kubectx # Not sure if this will be necessary after sourcing ~/.zshrc
compinit _kubens # Not sure if this will be necessary after sourcing ~/.zshrc
which _kubectx 
which _kubens

## Built-in time function

Source: [Is there any command like time but for memory usage](https://superuser.com/questions/480928/is-there-any-command-like-time-but-for-memory-usage/767491#767491)

`zsh` has a more powerful built-in `time` command than `bash` has, and the `zsh` version can report memory statistics.

Even if you don't regularly use `zsh` as your day-to-day shell, you can just run it when you need to gather these kinds of statistics.

Set the `TIMEFMT` environment variable to indicate the output you want. Here is what I have in my `.zshrc` file (perhaps a bit too fancy, but I like it):

    TIMEFMT='%J   %U  user %S system %P cpu %*E total'$'\n'\
    'avg shared (code):         %X KB'$'\n'\
    'avg unshared (data/stack): %D KB'$'\n'\
    'total (sum):               %K KB'$'\n'\
    'max memory:                %M MB'$'\n'\
    'page faults from disk:     %F'$'\n'\
    'other page faults:         %R'

Sample output:

    % time ls
    [... the output of ls, followed by:]
    ls -G   0.00s  user 0.00s system 91% cpu 0.004 total
    avg shared (code):         0 KB
    avg unshared (data/stack): 0 KB
    total (sum):               0 KB
    max memory:                668 MB
    page faults from disk:     0
    other page faults:         337
