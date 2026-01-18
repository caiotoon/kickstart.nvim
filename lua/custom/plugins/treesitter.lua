-- Override treesitter config to use the new API (nvim-treesitter was rewritten)
-- See: https://github.com/nvim-treesitter/nvim-treesitter
return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  config = function()
    local ts = require('nvim-treesitter')
    ts.setup({
      install_dir = vim.fn.stdpath('data') .. '/site',
    })

    -- Enable treesitter highlighting for all filetypes (built into Neovim)
    vim.api.nvim_create_autocmd('FileType', {
      pattern = '*',
      callback = function()
        pcall(vim.treesitter.start)
      end,
    })
  end,
}
