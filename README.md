# Neovim Config

Personal [LazyVim](https://github.com/LazyVim/LazyVim)-based Neovim config: Catppuccin, AI CLIs in a side panel, tmux-aware splits, and inline image rendering.

## Quick start

```bash
# 1. Install neovim and the tools LazyVim expects
brew install neovim ripgrep fd lazygit

# 2. Clone this config
git clone git@github.com:estherjk/nvim-config.git ~/.config/nvim

# 3. Launch — lazy.nvim bootstraps and installs everything on first run
nvim
```

Then run `:LazyHealth` to confirm nothing is missing.

Optional add-ons: [AI CLIs](#ai-tools), [tmux navigation](#tmux-navigation), and [image rendering](#image-rendering).

## Keymaps

The leader key is `Space`. Press it and wait for [which-key](https://github.com/folke/which-key.nvim) to show what's bound.

| Key               | Action               |
| ----------------- | -------------------- |
| `<leader><space>` | Find files           |
| `<leader>/`       | Search text in files |
| `<leader>e`       | File explorer        |
| `<leader>fn`      | New file             |
| `<leader>cr`      | Rename symbol        |
| `<leader>cf`      | Format code          |
| `<leader>bd`      | Close current buffer |
| `<leader>gs`      | Git status           |
| `<leader>gg`      | Lazygit              |
| `<leader>qq`      | Quit all             |

See the [LazyVim keymaps docs](https://www.lazyvim.org/keymaps) for the full list.

## AI tools

This config enables two AI integrations: [Claude Code](https://www.lazyvim.org/extras/ai/claudecode) (its own terminal split) and [Sidekick](https://www.lazyvim.org/extras/ai/sidekick) (any supported AI CLI in a side panel).

Install the CLIs you want:

```bash
curl -fsSL https://claude.ai/install.sh | bash  # claude
curl -fsSL https://pi.dev/install.sh | sh       # pi
brew install --cask codex                       # codex
```

| Key          | Action                                    |
| ------------ | ----------------------------------------- |
| `<leader>ac` | Toggle Claude Code                        |
| `<leader>ap` | Toggle pi in the side panel               |
| `<leader>ax` | Toggle codex in the side panel            |
| `<leader>as` | Pick a CLI from the full list             |
| `<leader>aP` | Pick a prompt to send to the attached CLI |
| `<leader>at` | Send the current context to the CLI       |
| `<leader>av` | Send the visual selection to the CLI      |
| `<C-.>`      | Focus the CLI panel                       |

Both integrations bind under `<leader>a`, and some shortcuts overlap (`aa`, `ad`, `af`, `as`) — press `<leader>a` and let which-key show which mapping is active.

## What's configured

LazyVim extras (`lazyvim.json`):

| Category   | [Extras](https://www.lazyvim.org/extras)                                                                            |
| ---------- | ------------------------------------------------------------------------------------------------------------------- |
| AI         | [Claude Code](https://www.lazyvim.org/extras/ai/claudecode), [Sidekick](https://www.lazyvim.org/extras/ai/sidekick) |
| Languages  | Astro, Docker, JSON, Markdown, PHP, Prisma, Python, SQL, Tailwind, TOML, TypeScript (vtsls), YAML                   |
| Formatting | Black (Python), Prettier (JS/TS)                                                                                    |

Custom plugin specs (`lua/plugins/`):

| Plugin                                                   | What it does                                                     |
| -------------------------------------------------------- | ---------------------------------------------------------------- |
| [sidekick.nvim](lua/plugins/sidekick.lua)                | Adds pi as a CLI tool, direct-open keys for pi/codex; NES off    |
| [catppuccin](lua/plugins/catppuccin.lua)                 | Catppuccin color scheme (the default)                            |
| [snacks.nvim](lua/plugins/explorer.lua)                  | File explorer showing hidden/ignored files, plus image rendering |
| [vim-tmux-navigator](lua/plugins/vim-tmux-navigator.lua) | Seamless Neovim/tmux split navigation                            |
| [nvim-lint](lua/plugins/nvim-lint.lua)                   | Points markdownlint at `.markdownlint.yaml` (MD013 off)          |

## tmux navigation

| Key      | Action                    |
| -------- | ------------------------- |
| `Ctrl-h` | Move left                 |
| `Ctrl-j` | Move down                 |
| `Ctrl-k` | Move up                   |
| `Ctrl-l` | Move right                |
| `Ctrl-\` | Go to previous split/pane |

Add this to `~/.tmux.conf` to use the same `Ctrl` shortcuts for moving between Neovim splits and tmux panes, then reload with `tmux source-file ~/.tmux.conf`:

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

## Image rendering

Images render directly in the buffer via [`snacks.image`](https://github.com/folke/snacks.nvim/blob/main/docs/image.md), using the [Kitty graphics protocol](https://sw.kovidgoyal.net/kitty/graphics-protocol/). Works in [Ghostty](https://ghostty.org/), Kitty, and WezTerm (limited).

These formats need [ImageMagick](https://imagemagick.org/): jpg, gif, webp, pdf, and svg.

```bash
brew install imagemagick
```

Run `:checkhealth snacks` to verify the setup.

## Troubleshooting

### `<leader>ap` says that pi cannot be found

This usually happens in a repository that uses a specific Node version. If you install pi with [nvm](https://github.com/nvm-sh/nvm), it is added to the Node version that was active at the time. When nvm switches Node versions, pi may disappear from Neovim’s command path.

Create a small launcher for pi in `~/.local/bin`. nvm does not change this directory, so the launcher will continue to work when you change repositories:

```bash
cat > ~/.local/bin/pi <<'EOF'
#!/bin/sh
# Always run pi with the Node version where it was installed.
PI_NODE_VERSION=v24.16.0
PI_ROOT="$HOME/.nvm/versions/node/$PI_NODE_VERSION"

exec "$PI_ROOT/bin/node" \
  "$PI_ROOT/lib/node_modules/@earendil-works/pi-coding-agent/dist/cli.js" "$@"
EOF
chmod +x ~/.local/bin/pi
```

If your current shell still cannot find pi, run `rehash` and try again. If you reinstall pi with a different Node version, update `PI_NODE_VERSION` in the launcher to match. The launcher is separate from npm, so npm can update the actual pi package without replacing it; check the launcher after updating pi.
