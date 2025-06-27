
local keymap = vim.keymap.set

-- Ventanas
keymap("n", "<C-h>", "<C-w>h")
keymap("n", "<C-j>", "<C-w>j")
keymap("n", "<C-k>", "<C-w>k")
keymap("n", "<C-l>", "<C-w>l")

-- Explorador
keymap("n", "<leader>e", ":NvimTreeToggle<CR>")

-- Telescope
keymap("n", "<leader>ff", ":Telescope find_files<CR>")
keymap("n", "<leader>fg", ":Telescope live_grep<CR>")
keymap("n", "<leader>fb", ":Telescope buffers<CR>")
keymap("n", "<leader>fh", ":Telescope help_tags<CR>")

-- Bufferline
keymap("n", "<Tab>", ":BufferLineCycleNext<CR>")
keymap("n", "<S-Tab>", ":BufferLineCyclePrev<CR>")
keymap("n", "<leader>x", ":BufferLinePickClose<CR>")

-- LSP
keymap("n", "gd", vim.lsp.buf.definition)
keymap("n", "gr", vim.lsp.buf.references)
keymap("n", "gD", vim.lsp.buf.declaration)
keymap("n", "gi", vim.lsp.buf.implementation)
keymap("n", "K", vim.lsp.buf.hover)
keymap("n", "<C-k>", vim.lsp.buf.signature_help)
keymap("n", "<leader>rn", vim.lsp.buf.rename)
keymap("n", "<leader>ca", vim.lsp.buf.code_action)
keymap("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end)

-- Diagnóstico
keymap("n", "<leader>d", vim.diagnostic.open_float)
keymap("n", "[d", vim.diagnostic.goto_prev)
keymap("n", "]d", vim.diagnostic.goto_next)
keymap("n", "<leader>dl", vim.diagnostic.setloclist) -- Changed from <leader>q

-- DAP
keymap("n", "<F5>", ":DapContinue<CR>")
keymap("n", "<F10>", ":DapStepOver<CR>")
keymap("n", "<F11>", ":DapStepInto<CR>")
keymap("n", "<F12>", ":DapStepOut<CR>")
keymap("n", "<leader>b", ":DapToggleBreakpoint<CR>")
keymap("n", "<leader>dr", ":DapToggleRepl<CR>")

-- Build (compatible con Windows)
local is_windows = vim.fn.has('win32') == 1 or vim.fn.has('win64') == 1
if is_windows then
  keymap("n", "<F9>", ":TermExec cmd='mingw32-make'<CR>")
  keymap("n", "<leader>m", ":TermExec cmd='if not exist build mkdir build && cd build && cmake -G \"MinGW Makefiles\" .. && mingw32-make'<CR>")
else
  keymap("n", "<F9>", ":TermExec cmd='make'<CR>")
  keymap("n", "<leader>m", ":TermExec cmd='mkdir -p build && cd build && cmake .. && make'<CR>")
end

-- Guardar/salir
keymap("n", "<leader>w", ":w<CR>")
keymap("n", "<leader>q", ":q<CR>")
keymap("n", "<leader>wq", ":wq<CR>")
keymap("n", "<leader>nh", ":nohl<CR>")

-- Git
keymap("n", "<leader>gs", ":Git<CR>")
keymap("n", "<leader>gp", ":Gitsigns preview_hunk<CR>")
keymap("n", "<leader>gt", ":Gitsigns toggle_current_line_blame<CR>")
keymap("n", "<leader>gr", ":Gitsigns reset_hunk<CR>")
keymap("n", "]c", ":Gitsigns next_hunk<CR>")
keymap("n", "[c", ":Gitsigns prev_hunk<CR>")
