-- Configuración específica para proyectos C++

-- Plantillas de código para proyectos nuevos
local M = {}

-- Función para crear un proyecto C++ básico
function M.create_cpp_project(project_name)
  local project_path = vim.fn.getcwd() .. "/" .. project_name
  
  -- Crear estructura de directorios
  vim.fn.mkdir(project_path .. "/src", "p")
  vim.fn.mkdir(project_path .. "/include", "p")
  vim.fn.mkdir(project_path .. "/build", "p")
  vim.fn.mkdir(project_path .. "/tests", "p")
  
  -- Crear CMakeLists.txt
  local cmake_content = [[cmake_minimum_required(VERSION 3.10)
project(]] .. project_name .. [[)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Incluir directorios
include_directories(include)

# Encontrar archivos fuente
file(GLOB SOURCES "src/*.cpp")

# Crear ejecutable
add_executable(]] .. project_name .. [[ ${SOURCES})

# Compilar con flags de debug
set(CMAKE_CXX_FLAGS_DEBUG "-g -O0 -Wall -Wextra")
set(CMAKE_CXX_FLAGS_RELEASE "-O3 -DNDEBUG")
]]
  
  local main_cpp = [[#include <iostream>

int main() {
    std::cout << "Hello, ]] .. project_name .. [[!" << std::endl;
    return 0;
}
]]
  
  -- Escribir archivos
  vim.fn.writefile(vim.split(cmake_content, "\n"), project_path .. "/CMakeLists.txt")
  vim.fn.writefile(vim.split(main_cpp, "\n"), project_path .. "/src/main.cpp")
  
  -- Crear .gitignore
  local gitignore = [[build/
cmake-build-*/
*.o
*.exe
*.dll
*.so
.vscode/
.idea/
]]
  vim.fn.writefile(vim.split(gitignore, "\n"), project_path .. "/.gitignore")
  
  print("Proyecto C++ creado en: " .. project_path)
end

-- Comando para crear proyecto
vim.api.nvim_create_user_command("CppProject", function(opts) 
  M.create_cpp_project(opts.args) 
end, { nargs = 1 })

-- Funciones de compilación mejoradas
-- Detectar sistema operativo
local is_windows = vim.fn.has('win32') == 1 or vim.fn.has('win64') == 1

function M.compile_debug()
  local cmd
  if is_windows then
    cmd = "cd build && cmake -DCMAKE_BUILD_TYPE=Debug -G \"MinGW Makefiles\" .. && mingw32-make"
  else
    cmd = "cd build && cmake -DCMAKE_BUILD_TYPE=Debug .. && make -j$(nproc)"
  end
  vim.cmd("AsyncRun " .. cmd)
end

function M.compile_release()
  local cmd
  if is_windows then
    cmd = "cd build && cmake -DCMAKE_BUILD_TYPE=Release -G \"MinGW Makefiles\" .. && mingw32-make"
  else
    cmd = "cd build && cmake -DCMAKE_BUILD_TYPE=Release .. && make -j$(nproc)"
  end
  vim.cmd("AsyncRun " .. cmd)
end

function M.compile_and_run()
  local cmd
  if is_windows then
    cmd = "cd build && cmake -G \"MinGW Makefiles\" .. && mingw32-make && for /f %i in ('dir /b *.exe') do %i"
  else
    cmd = "cd build && cmake .. && make -j$(nproc) && ./$(find . -maxdepth 1 -type f -executable | head -1)"
  end
  vim.cmd("AsyncRun " .. cmd)
end

function M.run_tests()
  local cmd = "cd build && ctest --output-on-failure"
  vim.cmd("AsyncRun " .. cmd)
end

function M.clean_build()
  local cmd
  if is_windows then
    cmd = "if exist build rmdir /s /q build && mkdir build"
  else
    cmd = "rm -rf build && mkdir build"
  end
  vim.cmd("AsyncRun " .. cmd)
end

-- Mapeos mejorados
vim.keymap.set("n", "<leader>cd", M.compile_debug, { desc = "Compile Debug" })
vim.keymap.set("n", "<leader>cr", M.compile_release, { desc = "Compile Release" })
vim.keymap.set("n", "<leader>ce", M.compile_and_run, { desc = "Compile and Run" })
vim.keymap.set("n", "<leader>ct", M.run_tests, { desc = "Run Tests" })
vim.keymap.set("n", "<leader>cc", M.clean_build, { desc = "Clean Build" })

return M
