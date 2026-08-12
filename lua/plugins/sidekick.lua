return {
  -- Merges with the ai.sidekick LazyExtra: adds the custom `pi` CLI tool and keys to open CLIs directly.
  -- Needs the pi CLI: curl -fsSL https://pi.dev/install.sh | sh
  -- Needs the codex CLI: brew install codex
  -- `cmd` resolves from PATH. If pi was installed as a global npm package under nvm,
  -- it vanishes inside repos that pin another Node version -- see README.md.
  {
    "folke/sidekick.nvim",
    opts = {
      nes = { enabled = false }, -- requires Copilot
      copilot = { status = { enabled = false } }, -- no sign-in warnings
      cli = {
        tools = {
          pi = { cmd = { "pi" } },
          -- codex ships with sidekick (sk/cli/codex.lua); listed here for discoverability.
        },
      },
    },
    -- stylua: ignore
    keys = {
      -- Open pi in the right split (overrides the extra's <leader>ap).
      { "<leader>ap", function() require("sidekick.cli").toggle({ name = "pi", focus = true }) end, desc = "pi (side panel)" },
      -- <leader>ac is ClaudeCode, so codex gets the x.
      { "<leader>ax", function() require("sidekick.cli").toggle({ name = "codex", focus = true }) end, desc = "codex (side panel)" },
    },
  },
}
