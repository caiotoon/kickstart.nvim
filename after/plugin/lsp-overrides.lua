-- Additional LSP server configurations
-- These merge with init.lua's nvim-lspconfig settings via vim.lsp.config()

-- Disable ts_ls globally — typescript-tools.nvim is used instead
vim.lsp.enable('ts_ls', false)

-- bashls: extend filetypes to include zsh
vim.lsp.config('bashls', {
  filetypes = { 'sh', 'zsh' },
})

-- lua_ls: complements init.lua's lua_ls config
-- NOTE: lazydev.nvim handles workspace library and vim globals on-demand,
-- so we do NOT set workspace.library here (that causes full re-indexing on every start).
vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      completion = {
        callSnippet = 'Replace',
      },
      workspace = {
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
    },
  },
})
