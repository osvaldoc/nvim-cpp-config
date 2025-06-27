return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        size = 20,
        open_mapping = [[<c-\>]],
        hide_numbers = true,
        shade_terminals = true,
        shading_factor = 2,
        start_in_insert = true,
        insert_mappings = true,
        persist_size = true,
        direction = "float",
        close_on_exit = true,
        shell = vim.fn.has('win32') == 1 and 'pwsh.exe' or vim.o.shell,
        float_opts = {
          border = "curved",
          winblend = 0,
          highlights = {
            border = "Normal",
            background = "Normal",
          },
        },
      })

      -- Terminal específico para build
      local Terminal = require("toggleterm.terminal").Terminal
      local build_terminal = Terminal:new({
        cmd = vim.fn.has('win32') == 1 and 'pwsh.exe' or 'bash',
        dir = "git_dir",
        direction = "float",
        float_opts = {
          border = "double",
        },
        on_open = function(term)
          vim.cmd("startinsert!")
          vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
        end,
        on_close = function(term)
          vim.cmd("startinsert!")
        end,
      })

      function _BUILD_TERMINAL_TOGGLE()
        build_terminal:toggle()
      end

      vim.api.nvim_set_keymap("n", "<leader>tb", "<cmd>lua _BUILD_TERMINAL_TOGGLE()<CR>", {noremap = true, silent = true})
    end,
  },
}
