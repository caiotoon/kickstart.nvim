return {
  'nvim-telescope/telescope.nvim',
  keys = {
    { '<leader>ff', function() require('telescope.builtin').find_files() end, desc = '[F]ind [F]iles' },
    { '<leader>fg', function() require('telescope.builtin').live_grep() end, desc = '[F]ind by [G]rep' },
    { '<leader>fb', function() require('telescope.builtin').buffers() end, desc = '[F]ind [B]uffers' },
    { '<leader>fh', function() require('telescope.builtin').help_tags() end, desc = '[F]ind [H]elp' },
    { '<leader>fu', function() require('telescope.builtin').lsp_references() end, desc = '[F]ind [U]sages/references' },
  },
  init = function()
    -- Modify telescope config after main setup completes
    vim.api.nvim_create_autocmd('VimEnter', {
      once = true,
      callback = function()
        vim.schedule(function()
          local config = require 'telescope.config'
          config.values.path_display = { 'smart' }
        end)
      end,
    })
  end,
}
