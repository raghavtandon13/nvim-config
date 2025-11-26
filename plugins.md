# Neovim Plugins - Lazy Loading Configuration

This document provides a comprehensive overview of all plugins in this Neovim configuration, their lazy loading setup, and the triggers that activate them.

## 🚀 Startup Performance Analysis

### Immediate Load Plugins (Impact Startup Time)

These plugins load immediately when Neovim starts:

| Plugin                          | Purpose    | Priority | Notes                     |
| ------------------------------- | ---------- | -------- | ------------------------- |
| **rose-pine/neovim**            | Theme      | High     | Loads on `VimEnter`       |
| **nvim-tree/nvim-web-devicons** | File icons | Medium   | No lazy loading specified |

---

## ⚡ Lazy Loaded Plugins

### Event-Based Loading

#### VeryLazy Event (After UI Idle)

Plugins that load after Neovim becomes idle:

| Plugin                   | Purpose               | Key Triggers              |
| ------------------------ | --------------------- | ------------------------- |
| **codecompanion.nvim**   | AI assistant          | None                      |
| **conform.nvim**         | Code formatter        | `<leader>cf`              |
| **nvim-lspconfig**       | LSP configurations    | None                      |
| **mason-lspconfig.nvim** | LSP installer         | None                      |
| **neo-tree.nvim**        | File explorer         | None                      |
| **mini.move**            | Text movement         | `Ctrl+Alt+Arrow keys`     |
| **mini.pairs**           | Auto-pairing          | None                      |
| **mini.surround**        | Surrounding text      | None                      |
| **flash.nvim**           | Quick navigation      | `s` key                   |
| **noice.nvim**           | UI improvements       | None                      |
| **todo-comments.nvim**   | TODO highlighting     | None                      |
| **vim-visual-multi**     | Multiple cursors      | None                      |
| **highlight-undo.nvim**  | Undo highlighting     | `u`, `Ctrl+r`             |
| **supermaven-nvim**      | AI code completion    | None                      |
| **lualine.nvim**         | Statusline            | None                      |
| **snacks.nvim**          | Multi-purpose utility | Multiple keys (see below) |

#### File Reading Events

| Plugin              | Event                   | Purpose                 |
| ------------------- | ----------------------- | ----------------------- |
| **gitsigns.nvim**   | `BufRead`               | Git signs               |
| **nvim-ufo**        | `BufRead`               | Code folding            |
| **treesj**          | `BufRead`               | Code splitting/joinning |
| **nvim-treesitter** | `BufRead`, `BufNewFile` | Syntax highlighting     |

#### Insert Mode Events

| Plugin              | Event         | Purpose           |
| ------------------- | ------------- | ----------------- |
| **nvim-cmp**        | `InsertEnter` | Completion engine |
| **supermaven-nvim** | `InsertEnter` | AI suggestions    |

#### LSP Events

| Plugin                | Event       | Purpose                |
| --------------------- | ----------- | ---------------------- |
| **lsp-progress.nvim** | `LspAttach` | LSP progress indicator |
| **inlay-hints.nvim**  | `LspAttach` | Inlay hints            |

#### UI Events

| Plugin                          | Event          | Purpose            |
| ------------------------------- | -------------- | ------------------ |
| **tiny-inline-diagnostic.nvim** | `VimEnter`     | Inline diagnostics |
| **which-key.nvim**              | `<leader>` key | Keybinding help    |

---

### Filetype-Based Loading

#### CSV Files

| Plugin               | Filetypes          | Purpose          |
| -------------------- | ------------------ | ---------------- |
| **rainbow_csv.nvim** | `csv`, `tsv`, etc. | CSV highlighting |
| **csvview.nvim**     | `csv`, `tsv`, etc. | CSV viewer       |

#### TypeScript/JavaScript

| Plugin                       | Filetypes                                    | Purpose              |
| ---------------------------- | -------------------------------------------- | -------------------- |
| **ts-error-translator.nvim** | `typescript`, `javascript`, etc.             | Error translation    |
| **tailwind-tools.nvim**      | `html`, `javascriptreact`, `typescriptreact` | Tailwind CSS support |

#### Other Filetypes

| Plugin            | Filetypes                           | Purpose            |
| ----------------- | ----------------------------------- | ------------------ |
| **markview.nvim** | `markdown`, `markdown_inline`, etc. | Markdown rendering |
| **vimtex**        | `tex`                               | LaTeX support      |
| **crates.nvim**   | `Cargo.toml`                        | Cargo.toml support |
| **lazydev.nvim**  | `lua`                               | Lua development    |

---

### Command-Based Loading

| Plugin           | Command                             | Purpose              |
| ---------------- | ----------------------------------- | -------------------- |
| **nvim-silicon** | `:Silicon`                          | Code screenshots     |
| **neogit**       | `:Neogit`                           | Git interface        |
| **snacks.nvim**  | `:SnacksPicker`, `:SnacksDashboard` | Picker and dashboard |

---

### Key-Based Loading

| Plugin             | Keys                              | Purpose                    |
| ------------------ | --------------------------------- | -------------------------- |
| **flash.nvim**     | `s` (normal/visual/operator mode) | Quick navigation           |
| **treesj**         | `<leader>m`                       | Code splitting/joinning    |
| **which-key.nvim** | `<leader>`                        | Keybinding help            |
| **snacks.nvim**    | Multiple `<leader>s*` keys        | File picking and searching |

---

## 🎯 Complete Key/Event Trigger List

### Leader Key Mappings

| Key               | Plugin         | Action                |
| ----------------- | -------------- | --------------------- |
| `<leader>cf`      | conform.nvim   | Format code           |
| `<leader>g*`      | gitsigns.nvim  | Git operations        |
| `<leader>m`       | treesj         | Split/join code       |
| `<leader>?`       | which-key.nvim | Show buffer keymaps   |
| `<leader>,`       | snacks.nvim    | Search open buffers   |
| `<leader>sa`      | snacks.nvim    | Search all files (D:) |
| `<leader>sd`      | snacks.nvim    | Search diagnostics    |
| `<leader>sh`      | snacks.nvim    | Search help           |
| `<leader>sw`      | snacks.nvim    | Grep word             |
| `<leader>ss`      | snacks.nvim    | Search pickers        |
| `<leader>so`      | snacks.nvim    | Search notes          |
| `<leader>sg`      | snacks.nvim    | Grep project          |
| `<leader><space>` | snacks.nvim    | Search files          |
| `<leader>sn`      | snacks.nvim    | Search Neovim config  |
| `<leader>gs`      | snacks.nvim    | Git status            |
| `<leader>s/`      | snacks.nvim    | Grep in open files    |

### Special Keys

| Key               | Plugin              | Action                      |
| ----------------- | ------------------- | --------------------------- |
| `s`               | flash.nvim          | Flash navigation            |
| `Ctrl+Alt+Arrows` | mini.move           | Move text/lines             |
| `u`, `Ctrl+r`     | highlight-undo.nvim | Undo/redo with highlighting |

### LSP-Related Keys

| Key        | Plugin   | Action                       |
| ---------- | -------- | ---------------------------- |
| `<space>b` | nvim-dap | Toggle breakpoint (disabled) |
| `<F1-F5>`  | nvim-dap | Debug controls (disabled)    |

---

## 📊 Optimization Summary

### ✅ Already Optimized

- All LSP-related plugins load appropriately
- Filetype-specific plugins are properly lazy-loaded
- Command-based plugins only load when needed
- Most UI elements are delayed until after startup

### 🔄 Recent Optimizations Applied

1. **snacks.nvim** - Split loading across multiple triggers:
   - File operations: `BufReadPre`, `BufNewFile`
   - Commands: `SnacksPicker`, `SnacksDashboard`
   - Keys: All `<leader>s*` mappings
2. **lualine.nvim** - Changed from `VimEnter` to `VeryLazy`
3. **which-key.nvim** - Changed from `VimEnter` to `<leader>` key trigger

### 🎯 Performance Impact

- **Low Impact**: Filetype and command-based plugins
- **Medium Impact**: `VeryLazy` event plugins
- **High Impact**: Theme and web-devicons (minimal impact)

This configuration is now highly optimized for fast startup times while maintaining full functionality.
