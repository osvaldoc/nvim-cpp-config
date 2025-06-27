
-- Configuración básica de Neovim
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a'

-- Búsqueda
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Editor
vim.opt.wrap = false
vim.opt.breakindent = true
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.signcolumn = 'yes'
vim.opt.cursorline = true

-- Indentación
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Performance
vim.opt.updatetime = 300
vim.opt.timeout = true
vim.opt.timeoutlen = 500

-- UI
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.opt.showmode = false
vim.opt.cmdheight = 1
vim.opt.laststatus = 3 -- Global statusline

-- Sistema
vim.opt.clipboard = 'unnamedplus'
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("cache") .. "/undo"

-- Splits
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Formateo
vim.opt.formatoptions:remove({ "c", "r", "o" })

-- Leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Configuración específica para Windows
if vim.fn.has('win32') == 1 then
  vim.opt.shell = 'pwsh.exe'
  vim.opt.shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command'
  vim.opt.shellquote = ''
  vim.opt.shellxquote = ''
end
