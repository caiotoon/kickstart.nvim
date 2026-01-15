return {
  'sindrets/diffview.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    require('diffview').setup()

    -- Keymaps
    vim.keymap.set('n', '<leader>dvo', '<cmd>DiffviewOpen<cr>', { desc = '[D]iff[v]iew [O]pen' })
    vim.keymap.set('n', '<leader>dvc', '<cmd>DiffviewClose<cr>', { desc = '[D]iff[v]iew [C]lose' })
    vim.keymap.set('n', '<leader>dvh', '<cmd>DiffviewFileHistory<cr>', { desc = '[D]iff[v]iew File [H]istory' })
    vim.keymap.set('n', '<leader>dvf', '<cmd>DiffviewFileHistory %<cr>', { desc = '[D]iff[v]iew Current [F]ile History' })
  end,
}
