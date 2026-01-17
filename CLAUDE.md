# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a Neovim configuration based on kickstart.nvim. It uses lazy.nvim for plugin management and follows a modular structure for custom plugins.

## Architecture

**Entry point:** `init.lua` - Contains core settings, keybindings, and base plugin definitions (~1000 lines, single-file philosophy from kickstart)

**Plugin organization:**
- `lua/kickstart/plugins/` - Base plugins from kickstart framework (debug, lint, etc.)
- `lua/custom/plugins/` - Custom user plugins (each file returns a plugin spec, auto-imported)
- `ftplugin/` - Filetype-specific configurations (e.g., `java.lua` for jdtls setup)

**Adding a new plugin:** Create a file in `lua/custom/plugins/` that returns a plugin spec table. It's automatically loaded via the `{ import = 'custom.plugins' }` statement in init.lua.

Strong preference to keep anything outside `lua/custom/` intact to avoid merge conflicts, so any new changes
should be added inside either that folder or `ftplugin` if possible.

## Key Configuration Patterns

**Plugin spec format:**
```lua
return {
  'owner/repo',
  ft = { 'filetype' },           -- lazy load on filetype
  event = 'VimEnter',            -- lazy load on event
  dependencies = { '...' },
  config = function() ... end,
  opts = { ... },                -- passed to setup()
}
```

**Settings conventions:**
- `vim.o` / `vim.opt` for options
- `vim.keymap.set` for keybindings
- `vim.api.nvim_create_autocmd` for autocommands

**Leader key:** `<space>`

## Language Support

| Language | LSP/Tooling | Config Location |
|----------|-------------|-----------------|
| Java | nvim-jdtls, maven.nvim, java-debug | `lua/custom/plugins/java*.lua`, `ftplugin/java.lua` |
| TypeScript | typescript-tools.nvim (priority 100) | `lua/custom/plugins/typescript.lua` |
| C# | omnisharp-vim | `lua/custom/plugins/csharp.lua` |
| Lua | lua_ls (via mason) | `init.lua` servers table |

## Key Bindings Reference

**Search/Find (`<leader>s*` and `<leader>f*`):**
- `<leader>sf` / `<leader>ff` - Find files
- `<leader>sg` / `<leader>fg` - Live grep
- `<leader>fu` - Find usages (LSP references)

**LSP (`gr*` prefix):**
- `grn` - Rename
- `gra` - Code action
- `grr` - References
- `grd` - Go to definition

**Git (`<leader>h*`):**
- `<leader>hs` - Stage hunk
- `<leader>hr` - Reset hunk
- `<leader>dvo` / `<leader>dvc` - Diffview open/close

**Navigation:**
- `<C-a>` - Add file to harpoon
- `<C-e>` - Harpoon menu
- `,` - Window picker

**Testing (Java):**
- `<leader>tt` - Run nearest test
- `<leader>tf` - Run test file
- `<leader>td` - Debug test

## Neovim Commands

- `:Lazy` - Plugin manager (update, sync, install)
- `:Mason` - Install LSP servers, formatters, linters
- `:ConformInfo` - Show active formatters

## Formatting

- Formatter: stylua (configured in `.stylua.toml`)
- Line width: 160 characters
- Quote style: single quotes (ForceDouble for call parentheses)
- Auto-format on save enabled (except C/C++)

## External Dependencies

Required: git, make, gcc, ripgrep, fd-find, xclip/xsel
Optional: Nerd Font (set `vim.g.have_nerd_font = true` in init.lua)
