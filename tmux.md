# tmux help
tmux is a terminal multiplexer: it enables a number of terminals to be created, accessed, and controlled from a single screen.  tmux may be detached from a screen and continue running in the background, then later reattached.

### Tmux alias
```bash
alias t=tmux
```

### Install tmux plugin manager
Clone tpm
```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```
Put these entries in your .tmux.conf
```bash
# List of plugins
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'
# Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
run '~/.tmux/plugins/tpm/tpm'
```
Reload tmux environment so TPM is sourced. 
```bash
tmux source ~/.tmux.conf
```
To actually install the plugins:
- Press `C-a I`

### Sessions related commands

__New session__

```bash
t new -s <session-name>
bind C-c
```

### Tmux commands to show options

```bash
# Show Global Options
tmux show-options -g

# Show Window Options
tmux show-options -w

# Show Server Options
tmux show-options -s
```

### Tmux commands to list all key bindings

```bash
tmux list-keys
```

