-- Herramientas específicas para C++
return {
  -- Formateo de código
  {
    "stevearc/conform.nvim",
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          cpp = { "clang-format" },
          c = { "clang-format" },
        },
        format_on_save = {
          timeout_ms = 500,
          lsp_fallback = true,
        },
      })
    end,
  },

  -- Análisis estático
  {
    "mfussenegger/nvim-lint",
    config = function()
      require("lint").linters_by_ft = {
        cpp = { "cppcheck" },
        c = { "cppcheck" },
      }

      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        callback = function()
          require("lint").try_lint()
        end,
      })
    end,
  },

  -- Navegación mejorada de código
  {
    "simrat39/symbols-outline.nvim",
    config = function()
      require("symbols-outline").setup()
    end,
  },

  -- Documentación automática
  {
    "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function()
      require("neogen").setup({
        enabled = true,
        languages = {
          cpp = {
            template = {
              annotation_convention = "doxygen"
            }
          }
        }
      })
    end,
  },

  -- Compilación asíncrona
  {
    "skywind3000/asyncrun.vim",
    config = function()
      vim.g.asyncrun_open = 6
    end,
  },
}
