
# 🧠 Neovim C++ Config

Configuración modular de Neovim optimizada para desarrollo en **C++**, usando `lazy.nvim`, LSP, autocompletado, depuración y una interfaz moderna.

## 📦 Requisitos

- Neovim ≥ 0.9
- `git`, `cmake`, `g++` o `clang++`
- En Fedora:
  ```bash
  sudo dnf install neovim cmake gcc-c++ gdb ripgrep fd-find
  ```

## 🔧 Instalación

1. Clona este repositorio en tu configuración de Neovim:

   ```bash
   git clone https://github.com/tu_usuario/nvim-cpp-config ~/.config/nvim
   ```

2. Abre Neovim para que `lazy.nvim` instale los plugins automáticamente:

   ```bash
   nvim
   ```

3. Ejecuta `:checkhealth` para verificar que todo esté correctamente instalado.

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

Abre la terminal en Neovim (`<C-\>`):

```bash
mkdir -p build && cd build
cmake ..
make
```

O usa `<F9>` o `<leader>m` para compilar automáticamente desde Neovim.

## 🐞 Depurar con GDB

1. Ejecuta con `<F5>`
2. Usa `<F10>`, `<F11>`, `<F12>` para navegación
3. Coloca breakpoints con `<leader>b`

## 📜 Licencia

MIT © [Tu Nombre]
