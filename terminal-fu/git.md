# git

#### Find a way with which to list the remote branches by their last modified date

```bash
alias gbage='for k in `git branch -r | perl -pe '\''s/^..(.*?)( ->.*)?$/\1/'\''`; do echo -e `git show --pretty=format:"%Cgreen%ci %Cblue%cr%Creset" $k -- | head -n 1`\\t$k; done | sort -r'
```

#### Track all remote git branches as local branches

```bash
for remote in `git branch -r | grep -v /HEAD`; do git checkout --track $remote ; done
```

#### Get a diff between the changes in my working directory and tracked remote branch

```bash
git fetch origin master
git diff --stat HEAD..FETCH_HEAD
# OR
git diff HEAD..FETCH_HEAD
# OR
git log -p HEAD..FETCH_HEAD
```
Worst case, use GUI tools like SourceTree and/or GitKraken

#### Handle git pull with rebase when you actually have [local uncommitted changes](https://cscheng.info/2017/01/26/git-tip-autostash-with-git-pull-rebase.html)

```bash
git pull --rebase --autostash
```

#### Check all the branches that have been merged to the current branch
```bash
git branch --no-merged <branch name>
```

If <branch name> left blank, it will show the result for the current local branch. By default this applies to only the local branches. The `-a` flag will show both local and remote branches, and the `-r` flag shows only the remote branches.

#### Delete all local branches that have been merged
This assumes that master and develop branches will NOT be deleted

```bash
git branch --merged | egrep -v "(^\*|master$|develop$)" | xargs git branch -d
```

#### Delete all remote branches that have been merged
This assumes that master and develop branches will NOT be deleted

```bash
git branch -r --merged | egrep -v "(\*|master$|develop$)" | sed 's/origin\///' | xargs -n 1 git push --delete origin
```

### Scratchpad

```
// Git Rewriting rebase --interactive, reset, checkout, revert (deep-dive)
http://git-scm.com/book/en/v2/Git-Tools-Rewriting-History
http://git-scm.com/blog/2011/07/11/reset.html
https://github.com/edx/edx-platform/wiki/How-to-Rebase-a-Pull-Request
Pull with --rebase
git pull --rebase
git config branch.autosetuprebase always (not sure if this thing should be global or local
What happens if you do a reset --hard while being on a non-master branch

// Git Merge, Git merge revert and abort (deep-dive)
http://stackoverflow.com/questions/501407/is-there-a-git-merge-dry-run-option

// Becoming a Git Master
http://www.slideshare.net/GoAtlassian/becoming-a-git-master-nicola-paolucci
https://medium.com/@porteneuve/30-git-cli-options-you-should-know-about-15423e8771df
https://bitbucket.org/durdn/cfg/src/master/.gitconfig?at=master
http://mislav.uniqpath.com/2010/07/git-tips/
https://www.andyjeffries.co.uk/25-tips-for-intermediate-git-users/
if you want to grep for changes… source: don’t fear the branch
git log --all --stat --graph --parents
git show --pretty=raw --stat <sha1>
author contributions
http://stackoverflow.com/questions/1265040/how-to-count-total-lines-changed-by-a-specific-author-in-a-git-repository
git summary|more
git log --author="Jenn Dodd" --pretty=tformat: --numstat (per file)
git log --author="Jenn Dodd" --oneline --shortstat
git log --author="Jenn Dodd" --pretty=tformat: --numstat
git-cal // https://github.com/k4rthik/git-cal
gibo // https://github.com/simonwhitaker/gibo
git up alias
http://stackoverflow.com/questions/15316601/in-what-cases-could-git-pull-be-harmful
git config --global alias.up '!git remote update -p; git merge --ff-only @{u}'
How to clone a single branch from a repo
git clone ssh://git@gitscm.cisco.com/dftscmr/crucible-sdaas-api.git --branch develop --single-branch crucible-api
how can I know in Git if a branch has already been merged into master?
git branch --merged lists the branches that have been merged into the current branch
git branch --no-merged lists the branches that have not been merged
By default this applies to only the local branches. The -a flag will show both local and remote branches, and the -r flag shows only the remote branches
how do i know if i am going to have a merge conflict
git format-patch $(git merge-base master demo)..demo --stdout | git apply --check -
try to create a git alias from this
open pr from command-line
...
how to handle prs where merge conflicts happen
...
show me file in a particular branch or SHA1
...
How to push all branches to remote server
...
How to push tags to remote server
...
How to update all remotes at the same time
git config remotes.default 'origin stash'
How to undo git add . if you do not have any commits
git rm -r --cached .
remote tracking of branches
- If you want to see the status of your remote branch tracking, run
  git remote show origin
  Or type:
  cat .git/config
- If you created  a branch, any branch (including master) that you want to push to remote origin, your best bet is to run:
  git push -u origin <branch-name>
  to not only push your content, but setup the upstream to run git pull/git push
- If you have a remote branch from someone else, you can do the two steps to get your hands on that code:
  git fetch (fetched everything down)
  git branch -a (so that you can see all your local and remote branches)
  git co -t origin/<remote-branch>
  or
  git branch <local-branch> <remote>/<branch>
- If a remote branch has been deleted, then run:
git remote update --prune
  to make sure all local remote refs are gone
- When you do that, and you do:
   git co <branch> (assuming local <branch> was tracking remote/<branch>)
   you will get an error:
   Your branch is based on 'origin/test', but the upstream is gone.
   git branch --unset-upstream
git log notes
git log <since>..<until> --stat
Display the commits reachable from <until> but not from <since>. These parameters can be either commit ID’s or branch names.
git diff notes
diff --git a/index.html b/index.html
index 9d51092..897ef18 100644
--- a/index.html
+++ b/index.html
When I run git diff —cached index.html, I get the new lines that are added to the cached vs the version that’s on the HEAD. What does index 9d51092..897ef18 100644 mean??
Similarly, when I run git diff index.html, I get the diff between the staging vs working directory. 
diff --git a/index.html b/index.html
index 897ef18..6f23aae 100644
--- a/index.html
+++ b/index.html
I wish I knew how to read the top of the diff output??
git rebase notes
http://code.tutsplus.com/tutorials/focusing-on-a-team-workflow-with-git--cms-22514
- If <branch> is specified, git rebase will perform an automatic git checkout <branch> before doing anything else. Otherwise it remains on the current branch
- Like the git merge command, git rebase requires you to be on the branch that you want to move
- Rebasing alllows us to integrate the most up-to-date version of master without a merge commit
- If you ever find yourself lost in the middle of a rebase and you’re afraid to continue, you can use the ‑‑abort flag to abandon it and start over from scratch
- Rebasing enables fast-forward merges by moving a branch to the tip of another branch. It effectively eliminates the need for merge commits, resulting in a completely linear history
- --root
Rebase all commits reachable from <branch>...This allows you to rebase the root commit(s) on a branch
Example:
I am branch ‘master'. I have worked some cool magic on branch ‘cool’. If I want to merge ‘cool’ onto ‘master’, i have to first be on ‘master’ branch before running the ‘merge’ command
>git co master
>git merge cool
Similarly, if I have some stuff that I did on the ‘crazy’ branch, and I want to rebase this ‘crazy’ branch onto the ‘master’ branch, i have to be on ‘crazy’ branch first
>git co crazy
>git rebase master
git status notes
?? in Red means it is not being tracked
M in Red means it has not yet been staged
M in green means it has been staged, but not committed
git reflog notes
The reflog is a chronological listing of our history, without regard for the repository’s branch structure. This lets us find dangling commits that would otherwise be lost from the project history
advanced git notes
- All additive
- zsh command line hackery (checkout atlassian’s liquid prompt)
- Porcelain Commands
  init, add, rm, mv, clean, commit, diff, log, status, reset, checkout, branch, tag, merge, stash, reset, clone, pull, push, remote, fetch, checkout-track, rebase, reflog, revert, cherry-pick, 
- Plumbing Commands
  ref spec: language to define refs
  hash-object, cat-file, update-index, write-tree, commit-tree, rev-parse, show, ls-tree
  gc, fsck, prune
git use cases to test out
- Create a simple folder to mimic the Git Internals folder and test out
  + Porcelain and Plumbing Commands
  + Local and Remote Commands
  + What exactly happens when you decide to “set upstream"
- Single Developer working with a Remote Repo
  Syncing master only; local repo has many branches
  Syncing master and ‘feature’ branch; local repo has many branches
  Rebase local branches
  Merge local branches
  Merge local and remote branch
- Three Developers working with a Remote Repo
  Master Branch is the one that is always ready for production
  Tags on Master (or Hot-Fix) Branch maps it to actual releases
  Developers have many local branches
  Developer 1 and Developer 2 have remotes to each other’s work
- Features to do deep-dive in
  + How do I diff between working directory and index
  + How do I diff between index and last commit
  + How do I diff between range of commits
  + How do I diff between local and remote branch
  + How does Git handle ‘rm’ or ‘mv’
git notes
- Create a new branch ‘i18n'. Start working on it. Keep the branch up-to-date with the the changes in the master
(How?) 
— By merging
- Keep merging from ‘i18n’ to ‘master’ once-a-day or frequently
- FF Merge (?)
- How does Git know that my local branch is <number> of commits ahead of the remote branch and that the remote branch is <number> of commits ahead of local branch
— Because it should be fairly easy to just move local pointer back until you hit the Commit N object that the remote branch is at
- Working with others is unbelievable easy. You ask in an IRC room if someone has implemented a feature in a library you are using. Turns out that someone has and you are sent the URL of their public Git repo for that project. You..
+ Add it as a remote
+ Fetch it
+ Create a new merge-feature branch off your development branch
+ merge in the new changes
- When Git decided to put objects under objects/ folder using the first two characters as folder name, Tim Berglund in his talk "Git fro Bits Up" said that Git divided that problem by 256. How? I guess the real question is how many permutations can exist for:
<alpha><beta>
where <alpha> and <beta> can be anything from 0 to 9 and a to z

// Git Workflow Dos and Donts
- Use master and develop branches to get going
- Think master branch as ‘production’ branch. code from the master branch gets deployed into production. If all goes well, make sure to go back to master branch and tag it with release-date (or release-version)
- Think develop branch as ‘staging’ branch. code from the develop branch gets deployed into dev/staging environment
- Make both master and develop protected branches
- Code goes into the master and develop branches primarily using Pull Requests ONLY (or as much as possible)
- Setup CI job for the master branch
- CI triggers stable branch setup cloning the configuration for master branch
- CI enable stable and protected branches (branches like master, develop, release/q2fy15, etc.) to be automatically triggered upon ‘commits’ (read, merges) into these branches
- CI enable “all” feature/, bugfix/ and hotfix/ branches, but don’t automatically trigger the CI for these branches. Let developers trigger it automatically (preferably from command-line, IDE plugin or logging into CI web app)
- Commits to “all” branches should trigger email to the entire dev/leads team (optionally configurable) owning the repo
- CI team performs shallow clones before running jobs wherever possible
- If shallow clones are not possible, CI caches repo on the executors
- Perform often (hourly or daily) rebase (or merge) of develop branch into your feature branch
- Do not perform FF merge when merging pull requests
- Use master to spawn off hotfix/ branch. When complete, merge it into develop branch and trigger CI on it. If successful, merge code from hotfix/ to master (not develop to master as usually done) 
- Use develop branch to spawn off feature/ branch. When complete, merge it back to develop/ which triggers automatic CI
- Use bugfix/ (or release/) branch to spawn off bugfix/ branch. When complete, merge it into develop/ branch and after successful CI back into release/ branch
- Use develop/ branch to spawn off release/ branches. After a few ‘last minute fixes” commits, use release/ branch to deploy code (typically code that’s an SDK). you do not need a release/ branch if you make sequential releases and do not support old releases
- Use pull requests to collaborate about the work being performed on the feature/,  bugfix/ and hotfix/ branches with your peers. the folks who approve it will still be the leads ONLY. unfortunately, stash today does not support the notion of ‘reviewers’ and ‘cc’ list. certainly not a show stopper
- Collaboration can be done at commit, single file or line level
- Always, always use pull requests to perform detailed code review before merging the code from feature/bugfix branches into develop branches

// Best Practices while working with Git
The general rules are essentially the same as for branch creation:

Commit a snapshot for each significant addition to your project.
Don’t commit a snapshot if you can’t come up with a single, specific message for it.
--
That said, it’s important to note that remotes are for people, whereas branches are for topics. Do not create separate branches for each of your developers—give them separate repositories and bookmark them with git remote add. Branches should always be for project development, not user management
--
Never, ever rebase commits that have been pushed to a shared repository

// Atlassian-stash ruby gem
http://www.rubydoc.info/gems/atlassian-stash/0.4.1/frames
https://bitbucket.org/atlassian/stash-command-line-tools/src/472b021d152a64e97efdbcfb22a6a959d94c8461?at=master

// SourceTree
I like the Date Order view of the branch history better than the Ancestor order. Wonder how we can do it using git log?

// Handle big repositories
http://blogs.atlassian.com/2014/05/handle-big-repositories-git/

// Git Concepts
Looking inside a Blob
> python
>>> fd = open("sha1 file name", "rb")
>>> line = fd.read()
>>> import zlib
>>> zlib.decompress(line)
How to unpack a Git Database (http://willi.am/blog/2014/10/14/unpacking-a-git-database/)
mv .git/object/pack/pack-*.pack .
cat pack-*.pack | git unpack-objects
rm pack-*.pack
Notes
- If you had only file, and you ran a git add, you will create 1 blob in the objects/ folder - The SHA1 of the file as it stands at the moment you ran the git add. That's it
- However, when you run a git commit, it will add 2 more blobs in the objects/ folder - The Commit blob and the Tree blob. 
- The Commit blob contains pointer to 'tree', pointer to it's parent 'commit' blob, if any and basic Commit related info like who committed, what's the message etc
- The Tree blob contains pointers to file/folder blob objects
- As far as Git is concerned, there is no git compare between local and remote branches. All remote branches are first fetched (basically, all the commit objects on that remote branch including the actual objects) and then you run your compares locally, just like if you were comparing two local branches
- Every commit is also captured as an 'object' with its own unique SHA. There is no concept of v1, v1.1 etc in a distributed SCM
- Repository <-> Index <-> Working Dir
- When you checkout, you get stuff from Repository into Index and then into Working Dir. When you modify files in Working Dir and run add, the index gets updated. That's why after an add, you can delete the Working Dir and still be able to commit, since the Index is what commit operates on
- All the blobs happen when you run git add
- Branches are lightweight movable pointers to your directed graph
- master branch is the default branch
- HEAD is a symbolic reference that will always be pointing to one of your "pointers", your branches. It always points to the one that's current or the last known state of your working directory
- Whatever HEAD is pointing at becomes the parent of your next commit
- HEAD moves to whatever you did when you ran git commit
- The only pointer (read, branch) that moves is the one that the HEAD is pointing at 
- When you run git merge <branch-name>, it tries to find the best merge base that it can use. And it keeps updating that merge base thereby making it super easy to keep running merges from your branch
- Why are branches cool?
     -> Try out an idea. If it does not work, go back to master and delete the branch
     -> A branch for every bug. Basically isolate work units
     -> Long running topics
- Create a branch. Keep working on it by getting the latest from the master branch. And then when you are ready, run merge. And it will do fast-forward merge. Git is really doing a simple calculation: Is the commit that I am merging into reachable from the commit that I am merging from. If the two commits are not reachable, then it will do what's called a non-fast forward merge. In that case, it will walk-thru the tree and find the first best common merge base. This is the beauty of branch & merge in Git. It keeps doing this calculation of merge base for you (the developer)
- Merge conflict happens when the branch that you are committing to and the branch that you are committing from both have modified not just the same file, but the "same hunk" of the file
- In the case, Git will stop the merge commit. It will spit out a message about merge conflict. Run git status to find which file or file(s) are unmerged. If you git log, it will show the two commits that modified this "unmerged" file which caused the conflict. 
- Run git mergetool (or just use ST/Vim) to fix the conflict. After that, run git add <unmerged-file-name> to add it back to the Index/Staging area and then run the commit
- Remotes: Alias for a URL (file:// or http:// or git://)
- If you did an init, you are not going to have an 'origin' (a remote). If you did a clone, you will have an origin ('remote')
- We get all the branches from the remote repository when we clone. The local HEAD points to a branch with the same name as the one that the remote's HEAD was on at the time of the clone

// Git Commands
git init
git add . | git add <filename>
git commit -m "blah blah"
git commit -m -a "blah blah"
git commit --amend (if you want to make edits to the most recent commit) | git commit --amend -c HEAD
git clone git@github.com:indrayam/<remote-repo-name>.git <localrepo-name>
git bisect ??
git reset HEAD <filename> | git rm --cached <filename> The reset command resets the staging area to be whatever is in HEAD. This clears the staging area of the change we just staged. The reset command (by default) doesn’t change the working directory.
git revert HEAD/SHA-1 of any Commit (to Revert the changes of any Commit)
git checkout SHA-1/Commit <filename>
git mv <orig filename> <new filename> followed by git commit -m "comment around moving file"
git rm <filename> | git rm -r <dir name> followed by git commit -m "comment around deleting file/dir"
Branches move; Tags stay put
Default Branch is called 'master'
Merge in Git: Fast-forward merge (atypical) and Recursive Merge (typical)
git branch <branch name> <commit-id, tag name, branch name> followed by git checkout
or
git checkout -b <branch name> <commit-id, tag name, branch name>. By checking out a branch by name, you go to the lastest version of that branch. You can checkout by SHA-1 of the commit object and you will enter a detached HEAD state. Why detached HEAD? Because HEAD is supposed to be a reference to the last commit in the current checked out branch.
git branch (view local branches)
git branch -a (all branches)
git branch -r (remote branches)
git branch --merged (all branches that are merged into current branch)
git branch --no-merged (all branches that are NOT merged into current branch)
git branch --contains SHA-1/Commit (all branches that contain that commit)
git merge <branch name that is being merged>
git merge --no-ff <branch name that is being merged>
git merge  -m "merge message" <branch name that is being merged>
git merge --log <branch name that is being merged>
Using a nice merge tool with Git on MacOSX (perforce)
git log --pretty=format:"%h %ad | %s%d [%an]" --graph --date=short
git log --pretty=oneline --max-count=2
git log --pretty=oneline --since='5 minutes ago'
git log --pretty=oneline --until='5 minutes ago'
git log --pretty=oneline --author=<your name>
git log --pretty=oneline --all
Commands to work with a local/remote repository:
git clone
     <test using over SSH on inme>
git remote add <name> <url>
git remote rm <name>
git fetch | git merge
git pull
git push
Commands to look at git internals:
git rev-parse HEAD
git cat-file -t SHA-1 (type of SHA-1)
git cat-file -s SHA-1  (size of SHA-1)
git cat-file -p SHA-1 (pretty print value of object SHA-1 points to)
git cat-file blob SHA-1 (print content of the object SHA-1 points to)
git cat-file commit SHA-1 (print content of the object SHA-1 points to)
git ls-tree <commit or blob>^{tree}
git ls-tree -rt <tree> (recurse into trees, show trees while recursing)
git hash-object -t blob <filename> (compute the hash value of a file)
git update-ref HEAD SHA-1/Commit Object
gitconfig
git config --global user.name "Anand Sharma"
git config --global user.email "anand.sharma@gmail.com"
git config --global color.ui auto
git config --global core.editor /usr/bin/vim
git config --global core.excludesfile ~/.gitignore
git config --global core.autocrlf input (true for windows)
git config --global core.safecrlf true

git config --global user.name "Anand Sharma"
git config --global user.email "anand.sharma@gmail.com"
…create your project folder template
…for example: >rails new test
git init
…You do not need a server, so start using "git init" everywhere
…objects and refs are two critical folder inside .git folder
…objects literally is the database of git while refs stores the pointers
git clone
…Another way to get a repository on your machine. You can do it over SSH/SCP, HTTP or file
git add .
…Creates a snapshot of all the changes in your working directory. 'git commit' will act on the ...files that were part of the last snapshot (or that was 'staged')
git commit -m "initial commit"
…git commit never looks at your working directory. It works off of the staging files only
…make your changes
git commit -am "<commit message>"
git checkout -b <branch-name> (creates a new branch and switches you to it. most popular form of creating a branch cause you want to move into the branch you created)
or
git branch <branch-name> will do the same
or git checkout -b <branch-name> master
…and git will create a branch with the new name and point it to wherever master was pointing to
…make your changes
git commit -am
git checkout master
…fast context-switching to the master branch
…only allowed after you have committed
…if you have not, and you want to switch branches, you can use 'git stash'
git branch
…lists all the branch with an "asterisk" next to the branch the folder is on
git merge <branch-name>
…this will merge the changes from <branch-name> into the current branch: master
…btw, git allows you to do reintegration merges, meaning you can go back to <branch-name>
…make more changes and merge these "new" changes back into master
git mergetool
…Depending upon how you have configured it in your .gitconfig, it can fire off your "merge tool" of choice (P4Merge or vimdiff or Kaleidoscope)
[mergetool "p4merge"]
    cmd = p4merge $BASE $LOCAL $REMOTE $MERGED
    trustExitCode = false
    keepBackup = false
    prompt = false
OR
[merge]
 keepBackup = false;
 tool = p4merge
[mergetool "p4merge"]
 cmd = p4merge "$BASE" "$LOCAL" "$REMOTE" "$MERGED"
 keepTemporaries = false
 trustExitCode = false
 keepBackup = false
OR
[merge]
tool = p4merge
[mergetool]
prompt = false
http://phatness.com/2012/01/merging-with-git-and-p4merge/
git branch -d <branch-name>
...delete the branch safely. If the branch that you're deleting is accessible from where you are, then it will traverse the tree/history and remove the pointer/branch. If it's not reachable, it's not going to do that.
git branch -D <branch-name>
...force delete it. It will remove the pointer, but the blobs, commits and tree objects will all still be there in the repository. They just would not be easily accessible
```
