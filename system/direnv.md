# direnv

## Install (on Mac or Linux)
```bash
brew install direnv
```

## Hook it to Zsh

Oh my zsh has a core plugin with direnv support.

Add direnv to the plugins array in your zshrc file:

```bash
# Update .zshrc's plugins configuration as follows
plugins=(... direnv)
```

## Define environment vars per folder

```bash
# Create a new folder for demo purposes.
$ mkdir ~/my-project
$ cd ~/my-project

# Show that the FOO environment variable is not loaded.
$ echo ${FOO-nope}
nope

# Create a new .envrc. This file is bash code that is going to be loaded by
# direnv.
$ echo export FOO=foo > .envrc
.envrc is not allowed

# The security mechanism didn't allow to load the .envrc. Since we trust it,
# let's allow its execution.
$ direnv allow .
direnv: reloading
direnv: loading .envrc
direnv export: +FOO

# Show that the FOO environment variable is loaded.
$ echo ${FOO-nope}
foo

# Exit the project
$ cd ..
direnv: unloading

# And now FOO is unset again
$ echo ${FOO-nope}
nope
```