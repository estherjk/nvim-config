# 💤 LazyVim

A starter template for [LazyVim](https://github.com/LazyVim/LazyVim).
Refer to the [documentation](https://lazyvim.github.io/installation) to get started.

## vim-tmux-navigator

Seamless navigation between Neovim splits and tmux panes using the same keybindings.

| Key | Action |
|-----|--------|
| `Ctrl-h` | Move left |
| `Ctrl-j` | Move down |
| `Ctrl-k` | Move up |
| `Ctrl-l` | Move right |
| `Ctrl-\` | Go to previous split/pane |

These keys work across both Neovim splits and tmux panes. At the edge of a Neovim split, the key moves into the adjacent tmux pane and vice versa.

Requires config on both sides:
- Neovim: `lua/plugins/vim-tmux-navigator.lua`
- tmux: `~/.tmux.conf`

### tmux setup

Copy the following into `~/.tmux.conf`, then reload with `tmux source-file ~/.tmux.conf`:

```bash
# Smart pane switching with awareness of Vim splits.
# See: https://github.com/christoomey/vim-tmux-navigator
vim_pattern='(\S+/)?g?\.?(view|l?n?vim?x?|fzf)(diff)?(-wrapped)?'
is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
    | grep -iqE '^[^TXZ ]+ +${vim_pattern}$'"
bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h'  'select-pane -L'
bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j'  'select-pane -D'
bind-key -n 'C-k' if-shell "$is_vim" 'send-keys C-k'  'select-pane -U'
bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l'  'select-pane -R'
tmux_version='$(tmux -V | sed -En "s/^tmux ([0-9]+(.[0-9]+)?).*/\1/p")'
if-shell -b '[ "$(echo "$tmux_version < 3.0" | bc)" = 1 ]' \
    "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\\\'  'select-pane -l'"
if-shell -b '[ "$(echo "$tmux_version >= 3.0" | bc)" = 1 ]' \
    "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\\\'  'select-pane -l'"
```
