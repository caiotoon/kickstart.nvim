return {
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    opts = {
      ensure_installed = { 'bash-language-server', 'shellcheck', 'shfmt' },
    },
  },
  {
    'neovim/nvim-lspconfig',
    config = function()
      local capabilities = require('blink.cmp').get_lsp_capabilities()
      vim.lsp.config('bashls', {
        capabilities = capabilities,
        filetypes = { 'sh', 'zsh' },
      })
      vim.lsp.enable('bashls')
    end,
  },
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        sh = { 'shfmt' },
        bash = { 'shfmt' },
        zsh = { 'shfmt' },
      },
    },
  },
}
