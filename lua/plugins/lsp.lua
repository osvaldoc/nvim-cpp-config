
return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      require("mason").setup({
        ui = {
          border = "rounded",
          width = 0.8,
          height = 0.8,
        },
      })
      require("mason-lspconfig").setup({
        ensure_installed = { "clangd", "cmake" },
        automatic_installation = true,
      })

      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      lspconfig.clangd.setup({
        capabilities = capabilities,
        cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
          "--header-insertion=iwyu",
          "--completion-style=detailed",
          "--function-arg-placeholders",
          "--fallback-style=llvm",
          "--cross-file-rename",
          "--suggest-missing-includes",
          "--all-scopes-completion",
          "--log=verbose",
        },
        init_options = {
          usePlaceholders = true,
          completeUnimported = true,
          clangdFileStatus = true,
        },
        on_attach = function(client, bufnr)
          local opts = { buffer = bufnr, silent = true }
          
          -- Mapeos específicos de LSP
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
          vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
          vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
          vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
          vim.keymap.set('n', '<leader>f', function()
            vim.lsp.buf.format({ async = true })
          end, opts)
          
          -- Highlight referencias
          if client.server_capabilities.documentHighlightProvider then
            vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
            vim.api.nvim_create_autocmd("CursorHold", {
              group = "lsp_document_highlight",
              buffer = bufnr,
              callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd("CursorMoved", {
              group = "lsp_document_highlight",
              buffer = bufnr,
              callback = vim.lsp.buf.clear_references,
            })
          end
        end,
      })

      lspconfig.cmake.setup({
        capabilities = capabilities,
      })
    end,
  },
}
