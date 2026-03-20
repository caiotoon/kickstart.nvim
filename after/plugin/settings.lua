-- Custom settings applied after all plugins are loaded.
-- Moved from lua/custom/plugins/init.lua to keep plugin spec files clean.

vim.opt.relativenumber = true

vim.keymap.set('n', '<leader>wm', ':tab split<CR>', { desc = 'Tab zoom' })
