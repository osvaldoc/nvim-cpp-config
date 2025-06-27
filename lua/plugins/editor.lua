return {
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        view = {
          width = 30,
        },
        renderer = {
          group_empty = true,
          icons = {
            glyphs = {
              folder = {
                arrow_closed = "⏵",
                arrow_open = "⏷",
              },
            },
          },
        },
        filters = {
          dotfiles = false,
          custom = { "node_modules", ".cache", "build", "cmake-build-*" },
        },
        git = {
          ignore = false,
        },
      })
    end,
  },
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        size = 20,
        open_mapping = [[<c-\>]],
        direction = "horizontal",
        shade_terminals = true,
      })
    end,
  },
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({})
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },
}
