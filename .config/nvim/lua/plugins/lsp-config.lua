return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "ts_ls", "pyright", "omnisharp" }
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- NEW API (Neovim 0.11+)
      -- Define server configs.
      vim.lsp.config.lua_ls = {
        capabilities = capabilities,
      }

      vim.lsp.config.ts_ls = {
        capabilities = capabilities,
      }

      vim.lsp.config.pyright = {
        capabilities = capabilities,
      }

      -- Example: OmniSharp updated to new API
      vim.lsp.config.omnisharp = {
        cmd = { vim.fn.expand("~/.local/share/nvim/mason/bin/OmniSharp") },
        enable_editorconfig_support = true,
        enable_roslyn_analyzers = true,
        organize_imports_on_format = true,
        enable_import_completion = true,
        capabilities = capabilities,
      }

      -- Start the language servers
      vim.lsp.start(vim.lsp.config.lua_ls)
      vim.lsp.start(vim.lsp.config.ts_ls)
      vim.lsp.start(vim.lsp.config.pyright)
      vim.lsp.start(vim.lsp.config.omnisharp)
      vim.lsp.start(vim.lsp.config.qmlls)

      -- KEYMAPS
      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
      vim.keymap.set("n", "mv", vim.lsp.buf.rename, {})
    end,
  }
}
