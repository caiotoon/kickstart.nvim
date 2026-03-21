return {
  'ThePrimeagen/99',
  dependencies = {
    { 'saghen/blink.compat', version = '2.*' },
  },
  config = function()
    local _99 = require '99'
    local cwd = vim.uv.cwd()
    local basename = vim.fs.basename(cwd)

    _99.setup {
      provider = _99.Providers.ClaudeCodeProvider,
      logger = {
        level = _99.DEBUG,
        path = '/tmp/' .. basename .. '.99.debug',
        print_on_error = true,
      },
      completion = {
        source = 'blink',
        custom_rules = {},
      },
      md_files = {
        'AGENT.md',
      },
    }

    -- Search: AI searches project and populates quickfix list
    vim.keymap.set('n', '<leader>9s', function() _99.search {} end, { desc = '[99] Search' })

    -- Visual: replace selection with AI-generated code
    vim.keymap.set('v', '<leader>9v', function() _99.visual {} end, { desc = '[99] Visual replace' })

    -- Stop all in-flight AI requests
    vim.keymap.set('n', '<leader>9x', function() _99.stop_all_requests() end, { desc = '[99] Stop all requests' })

    -- Telescope: switch model on the fly
    vim.keymap.set('n', '<leader>9m', function() require('99.extensions.telescope').select_model() end, { desc = '[99] Select model' })

    -- Telescope: switch provider on the fly
    vim.keymap.set('n', '<leader>9p', function() require('99.extensions.telescope').select_provider() end, { desc = '[99] Select provider' })
  end,
}
