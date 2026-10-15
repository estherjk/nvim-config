return {
  "mfussenegger/nvim-lint",
  optional = true,
  opts = {
    linters = {
      ["markdownlint-cli2"] = {
        prepend_args = {
          "--config",
          vim.fn.stdpath("config") .. "/.markdownlint.yaml",
          "--",
        },
      },
      -- Run phpcs from the buffer's project root to use its vendor phpcs and ruleset.
      -- Function linter because nvim-lint's cwd must be a string.
      phpcs = function()
        local l = vim.deepcopy(require("lint.linters.phpcs"))
        l.cwd = vim.fs.root(0, { "phpcs.xml.dist", "phpcs.xml", "composer.json" })
        return l
      end,
    },
  },
}
