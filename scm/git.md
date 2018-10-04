# git

### Find a way with which to list the remote branches by their last modified date

```bash
alias gbage='for k in `git branch -r | perl -pe '\''s/^..(.*?)( ->.*)?$/\1/'\''`; do echo -e `git show --pretty=format:"%Cgreen%ci %Cblue%cr%Creset" $k -- | head -n 1`\\t$k; done | sort -r'
```

### Track all remote git branches as local branches

```bash
for remote in `git branch -r | grep -v /HEAD`; do git checkout --track $remote ; done
```

### Get a diff between the changes in my working directory and tracked remote branch

```bash
git fetch origin master
git diff --stat HEAD..FETCH_HEAD
# OR
git diff HEAD..FETCH_HEAD
# OR
git log -p HEAD..FETCH_HEAD
```
Worst case, use GUI tools like SourceTree and/or GitKraken

### Handle git pull with rebase when you actually have [local uncommitted changes](https://cscheng.info/2017/01/26/git-tip-autostash-with-git-pull-rebase.html)

```bash
git pull --rebase --autostash
```

### Check all the branches that have been merged to the current branch
```bash
git branch --no-merged <branch name>
```

If <branch name> left blank, it will show the result for the current local branch. By default this applies to only the local branches. The `-a` flag will show both local and remote branches, and the `-r` flag shows only the remote branches.

### Delete all local branches that have been merged
This assumes that master and develop branches will NOT be deleted

```bash
git branch --merged | egrep -v "(^\*|master$|develop$)" | xargs git branch -d
```

### Delete all remote branches that have been merged
This assumes that master and develop branches will NOT be deleted

```bash
git branch -r --merged | egrep -v "(\*|master$|develop$)" | sed 's/origin\///' | xargs -n 1 git push --delete origin
```

### Fork and Sync

[Checkout PR Locally](https://gist.github.com/indrayam/2f1b81ce33d1a6f30140d4d5f2b79b37)
[GitHub Forking](https://gist.github.com/indrayam/c5376735e5702d5cfc7f1646f64af2d8)
