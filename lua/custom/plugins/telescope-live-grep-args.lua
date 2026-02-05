return {
  'nvim-telescope/telescope-live-grep-args.nvim',
  version = '^1.0.0',
  dependencies = { 'nvim-telescope/telescope.nvim' },
  config = function()
    local telescope = require 'telescope'
    local lga_actions = require 'telescope-live-grep-args.actions'

    telescope.setup {
      extensions = {
        live_grep_args = {
          auto_quoting = true, -- enable/disable auto-quoting
          mappings = {
            i = {
              ['<C-k>'] = lga_actions.quote_prompt(),
              ['<C-i>'] = lga_actions.quote_prompt { postfix = ' --iglob ' },
              ['<C-g>'] = lga_actions.quote_prompt { postfix = ' -g ' },
            },
          },
        },
      },
    }

    telescope.load_extension 'live_grep_args'

    -- Keybinding for live grep with args
    local live_grep_args = telescope.extensions.live_grep_args
    vim.keymap.set('n', '<leader>sG', live_grep_args.live_grep_args, { desc = '[S]earch with [G]rep args (rg flags)' })
  end,
}
