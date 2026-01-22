return {
  'sindrets/diffview.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    require('diffview').setup {
      keymaps = {
        file_panel = {
          ['<leader>gX'] = function()
            local view = require('diffview.lib').get_current_view()
            local file = view:infer_cur_file()
            if file then
              -- Get the base revision from the current view
              local base = view.left and view.left.commit or 'HEAD'
              local cmd = string.format('git checkout %s -- %s', vim.fn.shellescape(base), vim.fn.shellescape(file.path))
              vim.fn.system(cmd)
              vim.notify('Reverted ' .. file.path .. ' to ' .. base, vim.log.levels.INFO)
              vim.cmd 'DiffviewRefresh'
            end
          end,
        },
      },
    }

    -- Register with which-key for hint display
    require('which-key').add {
      { '<leader>gX', desc = 'Revert file to base revision' },
    }

    -- Keymaps
    vim.keymap.set('n', '<leader>dvo', '<cmd>DiffviewOpen<cr>', { desc = '[D]iff[v]iew [O]pen' })
    vim.keymap.set('n', '<leader>dvc', '<cmd>DiffviewClose<cr>', { desc = '[D]iff[v]iew [C]lose' })
    vim.keymap.set('n', '<leader>dvh', '<cmd>DiffviewFileHistory<cr>', { desc = '[D]iff[v]iew File [H]istory' })
    vim.keymap.set('n', '<leader>dvf', '<cmd>DiffviewFileHistory %<cr>', { desc = '[D]iff[v]iew Current [F]ile History' })
  end,
}
