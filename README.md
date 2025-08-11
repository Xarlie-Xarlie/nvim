# 🚀 Neovim Configuration

A comprehensive Neovim configuration focused on modern development workflow with LSP, AI assistance, and powerful productivity tools.

## 📁 Directory Structure

```
nvim/
├── init.lua                    # Entry point - sets up Lazy.nvim and loads core modules
├── lua/
│   ├── vim-options.lua         # Core Vim settings and options
│   ├── custom-functions.lua    # Custom utility functions and workflows
│   ├── icons.lua              # Icon definitions for UI components
│   └── plugins/               # Individual plugin configurations
│       ├── alpha.lua          # Dashboard/start screen
│       ├── autopairs.lua      # Auto-closing brackets/quotes
│       ├── bigfile.lua        # Performance optimizations for large files
│       ├── bufferline.lua     # Buffer tabs at the top
│       ├── catppuccin.lua     # Color scheme
│       ├── cmp.lua            # Autocompletion engine
│       ├── comment.lua        # Smart commenting
│       ├── copilot-chat.lua   # AI coding assistant
│       ├── fzf.lua            # Fuzzy finder integration
│       ├── gitsigns.lua       # Git integration for buffers
│       ├── illuminate.lua     # Highlight word under cursor
│       ├── indent-blankline.lua # Indentation guides
│       ├── lazydev.lua        # Lua development helpers
│       ├── lualine.lua        # Status line
│       ├── luasnip.lua        # Snippet engine
│       ├── marks.lua          # Enhanced mark management
│       ├── mason-lspconfig.lua # LSP server management bridge
│       ├── mason.lua          # LSP/DAP/Linter installer
│       ├── mini.lua           # Swiss army knife utilities
│       ├── neoscroll.lua      # Smooth scrolling
│       ├── nlsp-settings.lua  # LSP settings management
│       ├── noice.lua          # Enhanced UI for messages/cmdline/popupmenu
│       ├── none-ls.lua        # Null-ls successor for linters/formatters
│       ├── nvim-tree.lua      # File explorer
│       ├── nvim-ts-context-commentstring.lua # Context-aware commenting
│       ├── presence.lua       # Discord Rich Presence
│       ├── project.lua        # Project management
│       ├── recent-files.lua   # Recent files tracking
│       ├── render-markdown.lua # Live markdown rendering
│       ├── schemastore.lua    # JSON schema store
│       ├── structlog.lua      # Structured logging
│       ├── telescope.lua      # Fuzzy finder and picker
│       ├── toggleterm.lua     # Terminal management
│       ├── treesitter.lua     # Syntax highlighting and parsing
│       ├── ui-select.lua      # Enhanced vim.ui.select
│       └── which-key.lua      # Keybinding helper and configuration
└── .gitignore                 # Git ignore rules
```

## 🔌 Plugins Overview

### 🎨 **UI & Theme**
- **[catppuccin/nvim](https://github.com/catppuccin/nvim)** - Beautiful color scheme with latte flavor and transparency
- **[nvim-lualine/lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)** - Blazing fast statusline with custom sections
- **[akinsho/bufferline.nvim](https://github.com/akinsho/bufferline.nvim)** - Buffer tabs with pinning and management features
- **[goolord/alpha-nvim](https://github.com/goolord/alpha-nvim)** - Customizable dashboard/start screen
- **[folke/noice.nvim](https://github.com/folke/noice.nvim)** - Enhanced UI for messages, cmdline, and popupmenu

### 📁 **File Management**
- **[nvim-tree/nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua)** - File explorer with custom keybindings and auto-follow
- **[nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)** - Fuzzy finder for files, buffers, and more
- **[smartpde/telescope-recent-files](https://github.com/smartpde/telescope-recent-files)** - Recent files tracking
- **[ahmedkhalf/project.nvim](https://github.com/ahmedkhalf/project.nvim)** - Project management and root detection

### 🔧 **LSP & Development**
- **[williamboman/mason.nvim](https://github.com/williamboman/mason.nvim)** - LSP/DAP/Linter installer and manager
- **[neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)** - LSP configurations
- **[hrsh7th/nvim-cmp](https://github.com/hrsh7th/nvim-cmp)** - Autocompletion engine with multiple sources
- **[L3MON4D3/LuaSnip](https://github.com/L3MON4D3/LuaSnip)** - Snippet engine
- **[nvimtools/none-ls.nvim](https://github.com/nvimtools/none-ls.nvim)** - Linting and formatting

### 🌳 **Syntax & Editing**
- **[nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)** - Advanced syntax highlighting
- **[windwp/nvim-autopairs](https://github.com/windwp/nvim-autopairs)** - Auto-closing brackets and quotes
- **[numToStr/Comment.nvim](https://github.com/numToStr/Comment.nvim)** - Smart commenting with treesitter integration
- **[echasnovski/mini.nvim](https://github.com/echasnovski/mini.nvim)** - Collection of minimal utilities

### 🤖 **AI & Productivity**
- **[CopilotC-Nvim/CopilotChat.nvim](https://github.com/CopilotC-Nvim/CopilotChat.nvim)** - AI coding assistant with chat interface
- **[folke/which-key.nvim](https://github.com/folke/which-key.nvim)** - Keybinding helper with organized groups

### 📊 **Git Integration**
- **[lewis6991/gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)** - Git signs in the gutter with blame and hunk operations

### 🔧 **Terminal & Tools**
- **[akinsho/toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim)** - Multiple persistent terminals with floating support

## ⚙️ Key Custom Configurations

### 🎨 **Theme Configuration**
```lua
-- Catppuccin with transparency and custom styling
{
  flavour = "latte",           -- Light theme
  transparent_background = true,
  styles = {
    comments = { "italic" },
    conditionals = { "italic" },
    functions = { "bold" },
    keywords = { "bold" },
    strings = { "italic" },
  }
}
```

### 📁 **File Tree (nvim-tree)**
- **Custom keybindings**: `l`/`o`/`<CR>` to open, `h` to close directory, `v` for vertical split
- **Auto-follow**: Automatically finds and highlights the current file
- **Custom filtering**: Hides `node_modules` and `.cache` directories
- **Auto-close**: Closes when it's the last window

### 📊 **Status Line (lualine)**
- **Custom sections** with icons and git integration
- **File type indicators** with custom icons
- **Git branch and diff symbols** with color coding
- **Location and progress indicators**

### 🔍 **Completion (nvim-cmp)**
- **Multiple sources**: LSP, snippets, buffer, path, and signature help
- **Custom keybindings**: Tab/Shift-Tab for navigation, Ctrl+Space for completion
- **Rounded borders** for completion and documentation windows
- **Icon integration** from custom icon set

### ⌨️ **Keybindings (which-key)**
Organized into logical groups:
- **General**: Save, exit, file explorer (`<leader>w`, `<leader>q`, `<leader>e`)
- **Search**: Files, text, recent files, keymaps (`<leader>s*`)
- **Git**: LazyGit, hunks, blame, branches (`<leader>g*`)
- **LSP**: Diagnostics, formatting, code actions (`<leader>l*`)
- **Buffers**: Pin, close left/right (`<leader>b*`)
- **AI Chat**: CopilotChat commands (`<leader>z*`)
- **Terminal**: Horizontal, vertical, floating (`<C-1>`, `<C-2>`, `<C-3>`)
- **Tests**: Jest/Mix test runner (`<leader>t*`)

## 🛠 Custom Functions & Workflows

### 🔧 **QuickFix Toggle**
```lua
function QuickFixToggle()
```
Smart toggle for QuickFix window - opens if closed, closes if open.

### 🔍 **Custom Live Grep**
```lua
function CustomLiveGrep()
```
Enhanced live grep with include/exclude glob patterns for targeted searching.

### 📦 **LazyGit Integration**
```lua
function CustomLazyGitToggle()
```
Full-screen floating LazyGit terminal for git operations.

### 🤖 **AI Workflows**
- **Quick Chat**: `CustomQuickChat()` - Fast input for CopilotChat
- **PR Generation**: `CustomGeneratePullRequest()` - Generates pull request descriptions in Portuguese

### 🧪 **Test Runner**
```lua
function RunJestInFloatingWindow(current_file)
function ToggleJestFloatingWindow()
```
Floating window test runner supporting:
- **Jest** for JavaScript/TypeScript files
- **Mix** for Elixir files
- Real-time output streaming

## 📝 **Core Settings (vim-options.lua)**

### **Indentation & Formatting**
```lua
vim.cmd("set expandtab")         -- Use spaces instead of tabs
vim.cmd("set tabstop=2")         -- Tab width = 2 spaces
vim.cmd("set softtabstop=2")     -- Soft tab width = 2 spaces
vim.cmd("set shiftwidth=2")      -- Indent width = 2 spaces
```

### **UI Enhancements**
```lua
vim.opt.number = true            -- Line numbers
vim.opt.relativenumber = true    -- Relative line numbers
vim.opt.cursorcolumn = true      -- Highlight current column
vim.opt.termguicolors = true     -- True color support
vim.opt.signcolumn = "yes"       -- Always show sign column
```

### **Search & Navigation**
```lua
vim.opt.incsearch = true         -- Incremental search
vim.opt.ignorecase = true        -- Case insensitive search
vim.opt.smartcase = true         -- Smart case sensitivity
vim.opt.scrolloff = 8            -- Keep 8 lines above/below cursor
vim.opt.sidescrolloff = 8        -- Keep 8 columns left/right of cursor
```

### **Leader Key**
```lua
vim.g.mapleader = " "            -- Space as leader key
vim.g.maplocalleader = " "       -- Space as local leader
```

## 🚀 Installation

1. **Backup existing configuration** (if any):
   ```bash
   mv ~/.config/nvim ~/.config/nvim.backup
   ```

2. **Clone this configuration**:
   ```bash
   git clone https://github.com/Xarlie-Xarlie/nvim ~/.config/nvim
   ```

3. **Start Neovim**:
   ```bash
   nvim
   ```

4. **Lazy.nvim will automatically**:
   - Install itself on first run
   - Install all plugins
   - Set up the configuration

## 🎯 Usage

### **First-time Setup**
- Plugins install automatically on first launch
- Use `:Mason` to install additional LSP servers, formatters, and linters
- Use `:checkhealth` to verify everything is working correctly

### **Essential Keybindings**
- `<Space>` - Leader key
- `<Space>e` - Toggle file explorer
- `<Space>sf` - Find files
- `<Space>st` - Live grep
- `<Space>gg` - LazyGit
- `<Space>zc` - CopilotChat
- `<C-1>/<C-2>/<C-3>` - Terminal windows

### **Daily Workflow**
1. **Project Navigation**: Use `<Space>sf` for files, `<Space>e` for tree
2. **Code Search**: Use `<Space>st` for text search across project
3. **Git Operations**: Use `<Space>gg` for LazyGit interface
4. **AI Assistance**: Use `<Space>z*` commands for various AI workflows
5. **Testing**: Use `<Space>tt` to run tests for current file

## 🔧 Customization

### **Adding New Plugins**
Create a new file in `lua/plugins/` directory:
```lua
return {
  "author/plugin-name",
  opts = {
    -- configuration here
  }
}
```

### **Modifying Keybindings**
Edit the which-key configuration in `lua/plugins/which-key.lua`.

### **Changing Theme**
Modify `lua/plugins/catppuccin.lua` or replace with your preferred colorscheme.

## 📋 Dependencies

- **Neovim 0.9+** (required for latest features)
- **Git** (for plugin management and LazyGit)
- **Node.js** (for some LSP servers and CopilotChat)
- **Ripgrep** (for fast text searching)
- **LazyGit** (optional, for git workflow)

## 🤝 Contributing

Feel free to fork this configuration and adapt it to your needs. If you find improvements or fixes, pull requests are welcome!