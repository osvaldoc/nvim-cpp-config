
# 🧠 Neovim C++ Config

Configuración modular de Neovim optimizada para desarrollo en **C++**, usando `lazy.nvim`, LSP, autocompletado, depuración y una interfaz moderna.

## 📦 Requisitos

### Linux/macOS:
- Neovim ≥ 0.9
- `git`, `cmake`, `g++` o `clang++`
- En Fedora:
  ```bash
  sudo dnf install neovim cmake gcc-c++ gdb ripgrep fd-find
  ```

### Windows:
- Neovim ≥ 0.9
- Git for Windows
- **Una de las siguientes opciones de compilador:**
  - **MinGW-w64** (Recomendado para principiantes):
    ```powershell
    # Con Chocolatey
    choco install mingw
    # O descargar desde: https://www.mingw-w64.org/
    ```
  - **Microsoft Visual Studio** (2019 o 2022):
    - Incluir "C++ build tools" durante la instalación
  - **LLVM/Clang**:
    ```powershell
    # Con Chocolatey
    choco install llvm
    ```
- **CMake**:
  ```powershell
  # Con Chocolatey
  choco install cmake
  # O descargar desde: https://cmake.org/download/
  ```
- **Herramientas adicionales** (opcionales):
  ```powershell
  # Con Chocolatey
  choco install ripgrep fd ninja
  ```

## 🔧 Instalación

### Linux/macOS:
1. Clona este repositorio en tu configuración de Neovim:
   ```bash
   git clone https://github.com/tu_usuario/nvim-cpp-config ~/.config/nvim
   ```

### Windows:
1. Clona este repositorio en tu configuración de Neovim:
   ```powershell
   git clone https://github.com/tu_usuario/nvim-cpp-config "$env:LOCALAPPDATA\nvim"
   ```

### Todos los sistemas:
2. Abre Neovim para que `lazy.nvim` instale los plugins automáticamente:
   ```bash
   nvim
   ```

3. Ejecuta `:checkhealth` para verificar que todo esté correctamente instalado.

4. **Solo Windows**: Ejecuta `:CppCheckTools` para verificar las herramientas de compilación disponibles.

## 💻 Estructura del proyecto

```
~/.config/nvim/
├── init.lua
├── lua/
│   ├── core/         # Configuración básica (opciones, mapeos, autocomandos)
│   └── plugins/      # Plugins separados por función
```

## 🚀 Características

- 🎨 Tema `catppuccin-mocha`
- 🧩 Autocompletado con `nvim-cmp` + `LuaSnip`
- ⚙️ LSP configurado para `clangd` y `cmake`
- 🧪 Depuración con `nvim-dap` + GDB
- 🔍 Búsqueda con `telescope.nvim`
- 🌲 Árbol de sintaxis con `nvim-treesitter`
- 🧵 Bufferline, lualine, indent guides, toggleterm
- ⌨️ Mapas de teclas productivos y `which-key`

## 🔨 Compilar un proyecto C++

### Método 1: Terminal integrada
Abre la terminal en Neovim (`<C-\>`):

**Linux/macOS:**
```bash
mkdir -p build && cd build
cmake ..
make
```

**Windows (MinGW):**
```powershell
if (!(Test-Path build)) { mkdir build }
cd build
cmake -G "MinGW Makefiles" ..
mingw32-make
```

**Windows (Visual Studio):**
```powershell
if (!(Test-Path build)) { mkdir build }
cd build
cmake -G "Visual Studio 17 2022" ..
cmake --build . --config Debug
```

### Método 2: Atajos de teclado
- `<F9>` o `<leader>m` - Compilar automáticamente
- `<leader>cC` - Configurar proyecto (solo Windows)
- `<leader>cd` - Compilar en modo Debug
- `<leader>cr` - Compilar en modo Release
- `<leader>ce` - Compilar y ejecutar
- `<leader>cc` - Limpiar build

## 🐞 Depurar con GDB

1. Ejecuta con `<F5>`
2. Usa `<F10>`, `<F11>`, `<F12>` para navegación
3. Coloca breakpoints con `<leader>b`

## 📜 Licencia

MIT © [Tu Nombre]
