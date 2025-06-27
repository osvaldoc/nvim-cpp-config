
return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.4",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({
        defaults = {
          file_ignore_patterns = {
            "build/", "cmake%-build%-debug/", "cmake%-build%-release/",
            "%.o", "%.exe", "%.dll", "%.so"
          },
        },
      })
    end,
  },
}
