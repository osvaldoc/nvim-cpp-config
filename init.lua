
-- ~/.config/nvim/init.lua

-- Configuración base
require("core.options")
require("core.keymaps")
require("core.autocmds")

-- Plugins
require("core.lazy")

-- C++ específico
require("cpp.project")

-- Configuración específica para Windows
if vim.fn.has('win32') == 1 then
  require("cpp.windows").init()
end
