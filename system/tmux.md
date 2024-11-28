# tmux help
tmux is a terminal multiplexer: it enables a number of terminals to be created, accessed, and controlled from a single screen.  tmux may be detached from a screen and continue running in the background, then later reattached.

### Tmux alias
```bash
alias t=tmux
```

### Install tmux plugin manager
- Clone tpm

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```
- Put these entries in your .tmux.conf

```bash
# List of plugins
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'
# Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
run '~/.tmux/plugins/tpm/tpm'
```

- Reload tmux environment so TPM is sourced. 

```bash
tmux source ~/.tmux.conf
```
- To actually install the plugins, press `C-a I`

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

### Scratchpad

```bash
// Assumption: Following versions are installed on my Mac
tmux 2.5, vim 8.0.1171, iTerm2 3.1.2, reattach-to-user-namespace 2.6

// Reload changes to .tmux.conf while inside tmux
tmux source ~/.tmux.conf

// Making the clipboard work between iTerm2, tmux, vim and OS X
// https://evertpot.com/osx-tmux-vim-copy-paste-clipboard/
- “Allow clipboard access to terminal apps” must be OFF in iTerm2
- Add the following to .tmux.conf:
# Making the clipboard work between iTerm2, tmux, vim and OS X.
# Source: https://evertpot.com/osx-tmux-vim-copy-paste-clipboard/
# Copy-paste integration
set-option -g default-command "reattach-to-user-namespace -l zsh"

# Use vim keybindings in copy mode
setw -g mode-keys vi

# Setup 'v' to begin selection as in Vim
bind-key -T copy-mode-vi v send-keys -X begin-selection
bind-key -T copy-mode-vi y send-keys -X copy-pipe "reattach-to-user-namespace pbcopy"

# Update default binding of `Enter` to also use copy-pipe
unbind -T copy-mode-vi Enter
bind-key -T copy-mode-vi Enter send-keys -X copy-pipe "reattach-to-user-namespace pbcopy"

# Bind ']' to use pbpaste
bind ] run "reattach-to-user-namespace pbpaste | tmux load-buffer - && tmux paste-buffer"

# New window with default path set to last path
bind '"' split-window -c "#{pane_current_path}"
bind % split-window -h -c "#{pane_current_path}"
bind c new-window -c "#{pane_current_path}”

- Add the following to .vimrc
" Making the clipboard work between iTerm2, tmux, vim and OS X.
" Source: https://evertpot.com/osx-tmux-vim-copy-paste-clipboard/
set clipboard=unnamed

// Sessions
tmux new -s session-name (via command-line inside tmux)
tmux ls (via command-line inside tmux)
tmux kill-session -t session-name
tmux detach (via command-line inside tmux)
tmux attach -t <name>

Ctrl-b s (Show sessions)
Ctrl-b d (Detach session)
```

