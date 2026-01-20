return {
  'rachartier/tiny-inline-diagnostic.nvim',
  event = 'LspAttach',
  priority = 1000, -- Load after LSP
  config = function()
    require('tiny-inline-diagnostic').setup {
      -- Preset options: "modern", "classic", "minimal", "ghost", "simple", "nonerdfont", "amongus"
      preset = 'modern',

      -- Options for customization
      options = {
        -- Show diagnostic source
        show_source = true,

        -- Throttle time for diagnostics update (ms)
        throttle = 20,

        -- Enable multilines
        multilines = false,

        -- Show all diagnostics on the line
        multiple_diag_under_cursor = false,

        -- Break line after x characters
        break_line = {
          enabled = false,
          after = 80,
        },

        -- Virtual text options
        virt_texts = {
          priority = 9999,
        },

        -- Severity options
        severity = {
          vim.diagnostic.severity.ERROR,
          vim.diagnostic.severity.WARN,
          vim.diagnostic.severity.INFO,
          vim.diagnostic.severity.HINT,
        },
      },
    }

    -- Disable default virtual text since tiny-inline-diagnostic replaces it
    vim.diagnostic.config {
      virtual_text = false,
    }
  end,
}
