-- Java Testing Support
return {
  -- neotest: Testing framework
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-neotest/nvim-nio',
      -- Java test adapter
      'rcasia/neotest-java',
    },
    config = function()
      require('neotest').setup {
        adapters = {
          require 'neotest-java' {
            -- Default configuration
            ignore_wrapper = false, -- Use mvnw/gradlew if available
          },
        },
      }

      -- Test keymaps
      vim.keymap.set('n', '<leader>tt', function()
        require('neotest').run.run()
      end, { desc = '[T]est: Run nearest [T]est' })

      vim.keymap.set('n', '<leader>tf', function()
        require('neotest').run.run(vim.fn.expand '%')
      end, { desc = '[T]est: Run [F]ile' })

      vim.keymap.set('n', '<leader>td', function()
        require('neotest').run.run { strategy = 'dap' }
      end, { desc = '[T]est: [D]ebug nearest test' })

      vim.keymap.set('n', '<leader>ts', function()
        require('neotest').summary.toggle()
      end, { desc = '[T]est: Toggle [S]ummary' })

      vim.keymap.set('n', '<leader>to', function()
        require('neotest').output.open { enter = true }
      end, { desc = '[T]est: Show [O]utput' })
    end,
  },
}
