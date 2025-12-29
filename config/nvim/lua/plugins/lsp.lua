return {
  -- LSP Configuration using Neovim v0.11+ high-level functions
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "folke/neodev.nvim",
      "mfussenegger/nvim-jdtls",
    },
    config = function()
      -- Setup Mason
      require("mason").setup({
        ui = {
          border = "rounded",
        },
      })

      -- Setup Mason LSP Config
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "jdtls"
        },
        automatic_installation = true,
      })

      -- Keymaps when LSP attaches
      local on_attach = function(client, bufnr)
        local opts = { noremap=true, silent=true, buffer=bufnr }
        local keymap = vim.keymap.set

        -- LSP keymaps
        keymap("n", "gd", vim.lsp.buf.definition, opts)
        keymap("n", "gr", vim.lsp.buf.references, opts)
        keymap("n", "K", vim.lsp.buf.hover, opts)
        keymap("n", "<leader>rn", vim.lsp.buf.rename, opts)
        keymap("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        keymap("n", "<leader>D", vim.lsp.buf.type_definition, opts)
        keymap("n", "<leader>ds", vim.lsp.buf.document_symbol, opts)
        keymap("n", "<leader>ws", vim.lsp.buf.workspace_symbol, opts)
        keymap("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
        keymap("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
        keymap("n", "<leader>wl", function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        keymap("n", "<leader>f", vim.lsp.buf.format, opts)

        -- Show diagnostics in a floating window
        keymap("n", "<leader>e", vim.diagnostic.open_float, opts)
        keymap("n", "[d", vim.diagnostic.goto_prev, opts)
        keymap("n", "]d", vim.diagnostic.goto_next, opts)
        keymap("n", "<leader>q", vim.diagnostic.setloclist, opts)

        -- Buffer local options
        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
      end

      -- Configure LSP servers using Mason LSP Config
      local lspconfig = require('lspconfig')

      -- Lua (LuaLS)
      lspconfig.lua_ls.setup({
        on_attach = on_attach,
        settings = {
          Lua = {
            diagnostics = {
              globals = { 'vim' },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = { enable = false },
          },
        },
      })

      -- JSON
      lspconfig.jsonls.setup({
        on_attach = on_attach,
      })

      -- Configure LSP servers using Mason LSP Config
      local lspconfig = require('lspconfig')

      -- Mason LSP Config will automatically handle server startup
    end,
  },
}

