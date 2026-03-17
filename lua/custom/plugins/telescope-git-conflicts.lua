return {
  'Snikimonkd/telescope-git-conflicts.nvim',
  dependencies = {
    'nvim-telescope/telescope.nvim',
    'nvim-lua/plenary.nvim',
  },
  keys = {
    { '<leader>gc', '<cmd>Telescope conflicts<CR>', desc = '[G]it [C]onflicts' },
  },
  config = function()
    require('telescope').load_extension 'conflicts'
  end,
}
