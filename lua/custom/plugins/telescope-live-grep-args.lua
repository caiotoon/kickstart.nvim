return {
  'nvim-telescope/telescope-live-grep-args.nvim',
  version = '^1.0.0',
  dependencies = { 'nvim-telescope/telescope.nvim' },
  keys = {
    {
      '<leader>sG',
      function()
        require('telescope').extensions.live_grep_args.live_grep_args()
      end,
      desc = '[S]earch with [G]rep args (rg flags)',
    },
  },
  config = function()
    local telescope = require 'telescope'
    local lga_actions = require 'telescope-live-grep-args.actions'

    telescope.load_extension 'live_grep_args'

    -- Configure extension mappings via the extension's setup
    require('telescope-live-grep-args').setup {
      auto_quoting = true,
      mappings = {
        i = {
          ['<C-k>'] = lga_actions.quote_prompt(),
          ['<C-i>'] = lga_actions.quote_prompt { postfix = ' --iglob ' },
          ['<C-g>'] = lga_actions.quote_prompt { postfix = ' -g ' },
        },
      },
    }
  end,
}
