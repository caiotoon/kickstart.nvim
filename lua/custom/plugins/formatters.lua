-- Centralized formatter configuration for conform.nvim
-- init.lua provides: lua = { 'stylua' }
-- This file adds all other custom formatters.
return {
  'stevearc/conform.nvim',
  opts = {
    formatters_by_ft = {
      sh = { 'shfmt' },
      bash = { 'shfmt' },
      zsh = { 'shfmt' },
    },
  },
}
