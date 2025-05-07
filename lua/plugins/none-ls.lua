return {
  {
    "nvimtools/none-ls.nvim",
    dependencies = {
      "nvimtools/none-ls-extras.nvim",
    },
    config = function()
      local nls = require("null-ls") -- none-ls uses module name 'null-ls'

      -- Setup formatting and linting sources
      nls.setup({
        sources = {
          -- Formatter
          nls.builtins.formatting.prettier,

          -- Linter (eslint)
          --require("none-ls.diagnostics.eslint_d"),  -- Disabled to prevent errors ,here ESLint runs without a config file.

          -- Add stylua if editing Lua
          nls.builtins.formatting.stylua,
          -- To add new sources, include them here:
          -- e.g., nls.builtins.formatting.black or require("none-ls.diagnostics.flake8")
        },
        on_attach = function(client, bufnr)
          local bufmap = function(mode, lhs, rhs)
            vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true })
          end

          -- Format on demand keymap
          bufmap("n", "<leader>cf", function()
            vim.lsp.buf.format({ async = true })
          end, { desc = "Format" })
        end,
      })
    end,
  },
}
