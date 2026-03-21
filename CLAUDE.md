# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Contributing Rules (MANDATORY)

1. **NEVER modify kickstart files.** `init.lua` and `lua/kickstart/` are upstream from kickstart.nvim. Editing them causes merge conflicts when pulling updates. If the only fix requires touching these files, flag it to the user — do not proceed.

2. **All changes go in safe directories only:**
   - `lua/custom/plugins/` — one file per plugin, returns a lazy.nvim spec (auto-imported via `{ import = 'custom.plugins' }`)
   - `after/plugin/` — non-plugin config: keymaps, settings overrides, LSP config via `vim.lsp.config()`
   - `ftplugin/` — filetype-specific configurations

3. **Verify every change with headless nvim.** Before and after each change, run tests in `nvim --headless` to confirm assumptions and catch regressions. At minimum check: no startup errors, plugin count, and that the feature works. Document pre-test and post-test results.

## Overview

Neovim configuration based on kickstart.nvim. Uses lazy.nvim for plugin management.

## Architecture

**Entry point:** `init.lua` — core settings, keybindings, base plugin definitions (~1000 lines, upstream from kickstart)

**Plugin organization:**
- `lua/kickstart/plugins/` — base plugins from kickstart (DO NOT EDIT)
- `lua/custom/plugins/` — custom plugins (each file returns a plugin spec, auto-imported)
- `after/plugin/` — keymaps (`keymaps.lua`), settings (`settings.lua`), LSP overrides (`lsp-overrides.lua`)
- `ftplugin/` — filetype-specific configurations (e.g., `java.lua` for jdtls)

## Neovim Commands

- `:Lazy` — plugin manager (update, sync, install)
- `:Mason` — install LSP servers, formatters, linters
- `:ConformInfo` — show active formatters

## External Dependencies

Required: git, make, gcc, ripgrep, fd-find, xclip/xsel
Optional: Nerd Font (set `vim.g.have_nerd_font = true` in init.lua)
