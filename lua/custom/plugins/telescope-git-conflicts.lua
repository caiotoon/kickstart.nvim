return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'Snikimonkd/telescope-git-conflicts.nvim',
  },
  keys = {},
  config = function()
    require('telescope').setup {}
    require('telescope').load_extension 'conflicts'

    vim.keymap.set('n', '<leader>gc', '<cmd>:Telescope conflicts<CR>', { desc = '[G]it [C]onflicts' })
  end,
}
