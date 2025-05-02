return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim", -- Mason core plugin
      "williamboman/mason-lspconfig.nvim", -- Mason ⇄ lspconfig, connect mason and nvim
      "WhoIsSethDaniel/mason-tool-installer.nvim", -- Mason installer for formatters/linters
    },
    config = function()
      -- Mason setup
      local mason = require("mason")
      local mason_lspconfig = require("mason-lspconfig")
      local mason_tool_installer = require("mason-tool-installer")
      mason.setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })
      -- Install LSP servers (must match keyname in mason)
      mason_lspconfig.setup({
        ensure_installed = {
          "ts_ls",
          "html",
          "cssls",
          "jsonls",
          "tailwindcss",
          "lua_ls",
          "prismals",
          -- Add new LSP servers here and also add them below
        },
        automatic_installation = true,
      })

      -- Install formatters & linters
      mason_tool_installer.setup({
        ensure_installed = {
          "prettier",
          "eslint_d",
          "stylua", -- Lua formatter
          -- Add new formatter/linters here
        },
        auto_update = true,
        run_on_start = true,
      })
      -- on_attach: common keymaps for LSP features
      local on_attach = function(client, bufnr)
        local bufmap = function(mode, lhs, rhs)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true })
        end
        -- VS Code-like IDE features
        bufmap("n", "gd", vim.lsp.buf.definition)
        bufmap("n", "gr", vim.lsp.buf.references)
        bufmap("n", "K", vim.lsp.buf.hover)
        bufmap("n", "<leader>rn", vim.lsp.buf.rename)
        bufmap("n", "[d", vim.diagnostic.goto_prev)
        bufmap("n", "]d", vim.diagnostic.goto_next)
        bufmap("n", "<leader>q", vim.diagnostic.setloclist)
        bufmap("n", "<leader>f", function()
          vim.lsp.buf.format({ async = true })
        end)
      end
      -- Configure each LSP server
      local lspconfig = require("lspconfig")
      -- Server names in lspconfig are different from Mason package names
      local servers = {
        "tsserver", -- typescript-language-server in Mason
        "html", -- html-lsp in Mason
        "cssls", -- css-lsp in Mason
        "jsonls", -- json-lsp in Mason
        "tailwindcss", -- tailwindcss-language-server in Mason
        "lua_ls", -- lua-language-server in Mason
        "prismals", -- prisma-language-server in Mason
      }
      for _, server in ipairs(servers) do
        lspconfig[server].setup({ on_attach = on_attach })
      end
    end,
  },
}
