return {
  -- Merges with the ai.sidekick LazyExtra: adds the custom `pi` CLI tool and a key to open it directly.
  -- Needs the pi CLI: curl -fsSL https://pi.dev/install.sh | sh
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
        },
      },
    },
    -- stylua: ignore
    keys = {
      -- Open pi in the right split (overrides the extra's <leader>ap).
      { "<leader>ap", function() require("sidekick.cli").toggle({ name = "pi", focus = true }) end, desc = "pi (side panel)" },
    },
  },
}
