return {
  -- Merges with the ai.sidekick LazyExtra: adds the custom `pi` CLI tool and a key to open it directly.
  -- Needs the pi CLI: curl -fsSL https://pi.dev/install.sh | sh
  {
    "folke/sidekick.nvim",
    opts = {
      -- Disable NES (requires Copilot)
      nes = { enabled = false },
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
