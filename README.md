# Neovim Config

[LazyVim](https://github.com/LazyVim/LazyVim)-based config with Dracula theme.

## Installation

Install [neovim](https://neovim.io/doc/install/).

For macOS:

```bash
brew install neovim
```

Clone this repo:

```bash
git clone https://github.com/estherjk/nvim-config.git ~/.config/nvim
```

## Quick Reference

The leader key is `Space`. Press it and wait for [which-key](https://github.com/folke/which-key.nvim) to show all available keys.

Some useful keys:

| Key                | Action               |
| ------------------ | -------------------- |
| `<leader>e`        | File explorer        |
| `<leader>fn`       | New file             |
| `<leader><space>`  | Find files           |
| `<leader>/`        | Search text in files |
| `<leader>cr`       | Rename symbol        |
| `<leader>cf`       | Format code          |
| `<leader>bd`       | Close current buffer |
| `<leader>ac`       | Claude Code          |
| `<leader>gs`       | Git status           |
| `<leader>qq`       | Quit all             |

See the [LazyVim keymaps docs](https://www.lazyvim.org/keymaps) for the full list.

## LazyVim Extras

| Category   | [Extras](https://www.lazyvim.org/extras)                                           |
| ---------- | ---------------------------------------------------------------------------------- |
| AI         | Claude Code                                                                        |
| Languages  | Docker, JSON, Markdown, PHP, Python, SQL, Tailwind, TOML, TypeScript (vtsls), YAML |
| Formatting | Black (Python), Prettier (JS/TS)                                                   |

## Custom Plugins

| Plugin                                                   | Description                                    |
| -------------------------------------------------------- | ---------------------------------------------- |
| [vim-tmux-navigator](lua/plugins/vim-tmux-navigator.lua) | Seamless Neovim/tmux split navigation          |
| [dracula](lua/plugins/dracula.lua)                       | Dracula color scheme                           |
| [snacks.nvim](lua/plugins/explorer.lua)                  | File explorer showing hidden/ignored files     |
| [nvim-lint](lua/plugins/nvim-lint.lua)                   | Markdownlint with MD013 (line length) disabled |

## vim-tmux-navigator

Seamless navigation between Neovim splits and tmux panes using the same keybindings.

| Key      | Action                    |
| -------- | ------------------------- |
| `Ctrl-h` | Move left                 |
| `Ctrl-j` | Move down                 |
| `Ctrl-k` | Move up                   |
| `Ctrl-l` | Move right                |
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
