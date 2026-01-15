-- Java Debugging Support
return {
  'mfussenegger/nvim-dap',
  dependencies = {
    -- Java debug adapter
    {
      'microsoft/java-debug',
      build = './mvnw clean install',
      ft = 'java',
    },
  },
  config = function()
    local dap = require 'dap'

    -- Java DAP configuration
    dap.configurations.java = {
      {
        type = 'java',
        request = 'attach',
        name = 'Debug (Attach) - Remote',
        hostName = '127.0.0.1',
        port = 5005,
      },
      {
        type = 'java',
        request = 'launch',
        name = 'Debug (Launch) - Current File',
        mainClass = '${file}',
      },
    }

    -- Java DAP adapter
    dap.adapters.java = function(callback, config)
      callback {
        type = 'server',
        host = config.hostName or '127.0.0.1',
        port = config.port or 5005,
      }
    end

    -- Keymaps for debugging (if not already set)
    vim.keymap.set('n', '<F5>', function()
      require('dap').continue()
    end, { desc = 'Debug: Start/Continue' })

    vim.keymap.set('n', '<leader>b', function()
      require('dap').toggle_breakpoint()
    end, { desc = 'Debug: Toggle Breakpoint' })
  end,
}
