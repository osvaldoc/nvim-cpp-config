-- Configuración específica para desarrollo C++ en Windows
local M = {}

-- Detectar herramientas de build disponibles
function M.detect_build_tools()
  local tools = {}
  
  -- Verificar MinGW
  if vim.fn.executable('gcc') == 1 then
    tools.gcc = true
  end
  
  -- Verificar MSVC
  if vim.fn.executable('cl') == 1 then
    tools.msvc = true
  end
  
  -- Verificar Clang
  if vim.fn.executable('clang') == 1 then
    tools.clang = true
  end
  
  -- Verificar CMake
  if vim.fn.executable('cmake') == 1 then
    tools.cmake = true
  end
  
  -- Verificar Make/Ninja
  if vim.fn.executable('mingw32-make') == 1 then
    tools.make = 'mingw32-make'
  elseif vim.fn.executable('make') == 1 then
    tools.make = 'make'
  end
  
  if vim.fn.executable('ninja') == 1 then
    tools.ninja = true
  end
  
  return tools
end

-- Configurar comandos de build según las herramientas disponibles
function M.setup_build_commands()
  local tools = M.detect_build_tools()
  
  if not tools.cmake then
    vim.notify("CMake no encontrado. Instala CMake para mejor experiencia.", vim.log.levels.WARN)
  end
  
  if not (tools.gcc or tools.msvc or tools.clang) then
    vim.notify("No se encontró compilador. Instala MinGW, MSVC o Clang.", vim.log.levels.ERROR)
  end
  
  -- Configurar generator preferido
  local generator = ""
  if tools.ninja then
    generator = "-G Ninja"
  elseif tools.make then
    generator = "-G \"MinGW Makefiles\""
  elseif tools.msvc then
    generator = "-G \"Visual Studio 17 2022\""
  end
  
  return {
    generator = generator,
    make_cmd = tools.ninja and "ninja" or (tools.make or "mingw32-make"),
    tools = tools
  }
end

-- Configurar variables de entorno para MSVC si está disponible
function M.setup_msvc_env()
  if vim.fn.executable('cl') == 1 then
    -- Buscar vcvarsall.bat
    local vs_paths = {
      "C:\\Program Files\\Microsoft Visual Studio\\2022\\Community\\VC\\Auxiliary\\Build\\vcvarsall.bat",
      "C:\\Program Files\\Microsoft Visual Studio\\2022\\Professional\\VC\\Auxiliary\\Build\\vcvarsall.bat",
      "C:\\Program Files\\Microsoft Visual Studio\\2022\\Enterprise\\VC\\Auxiliary\\Build\\vcvarsall.bat",
    }
    
    for _, path in ipairs(vs_paths) do
      if vim.fn.filereadable(path) == 1 then
        vim.g.msvc_vcvarsall = path
        break
      end
    end
  end
end

-- Comando para configurar proyecto con detección automática
function M.auto_configure_project()
  local config = M.setup_build_commands()
  local build_type = vim.fn.input("Build type (Debug/Release): ", "Debug")
  
  local cmd = string.format(
    "cmake -DCMAKE_BUILD_TYPE=%s %s -B build",
    build_type,
    config.generator
  )
  
  vim.cmd("AsyncRun " .. cmd)
end

-- Inicializar configuración
function M.init()
  M.setup_msvc_env()
  
  -- Crear comandos
  vim.api.nvim_create_user_command("CppConfigureProject", M.auto_configure_project, {})
  vim.api.nvim_create_user_command("CppCheckTools", function()
    local tools = M.detect_build_tools()
    print("Herramientas disponibles:")
    for tool, available in pairs(tools) do
      print(string.format("  %s: %s", tool, tostring(available)))
    end
  end, {})
  
  -- Mapeos específicos para Windows
  vim.keymap.set("n", "<leader>cC", M.auto_configure_project, { desc = "Configure C++ Project" })
  vim.keymap.set("n", "<leader>cT", ":CppCheckTools<CR>", { desc = "Check C++ Tools" })
end

return M
