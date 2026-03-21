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

## Neovim Commands

- `:Lazy` - Plugin manager (update, sync, install)
- `:Mason` - Install LSP servers, formatters, linters
- `:ConformInfo` - Show active formatters

## External Dependencies

Required: git, make, gcc, ripgrep, fd-find, xclip/xsel
Optional: Nerd Font (set `vim.g.have_nerd_font = true` in init.lua)
