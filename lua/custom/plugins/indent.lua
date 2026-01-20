return {
  {
    'NMAC427/guess-indent.nvim',
    opts = {
      auto_cmd = true, -- Set to true to run on BufRead/BufNewFile
      override_editorconfig = false, -- Don't override editorconfig settings
      filetype_exclude = {
        'netrw',
        'tutor',
      },
      buftype_exclude = {
        'help',
        'nofile',
        'terminal',
        'prompt',
      },
    },
    config = function(_, opts)
      require('guess-indent').setup(opts)

      -- Set global defaults for indentation
      -- These will be overridden by guess-indent when it detects file-specific settings
      vim.opt.expandtab = true -- Use spaces instead of tabs
      vim.opt.tabstop = 2 -- Number of spaces a tab counts for
      vim.opt.shiftwidth = 2 -- Number of spaces for auto-indent
      vim.opt.softtabstop = 2 -- Number of spaces for <Tab> in insert mode
      vim.opt.smartindent = true -- Smart auto-indenting for new lines
    end,
  },
}
