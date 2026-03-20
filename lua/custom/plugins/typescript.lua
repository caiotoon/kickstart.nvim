return {
  'pmizio/typescript-tools.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'neovim/nvim-lspconfig',
  },
  ft = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
  config = function()
    -- Find tsserver.js in sub-project node_modules (Rush monorepo support)
    local tsserver_path = nil
    local search_patterns = {
      'node_modules/typescript/lib/tsserver.js',
      'projects/*/node_modules/typescript/lib/tsserver.js',
      'projects/apps/*/node_modules/typescript/lib/tsserver.js',
      'projects/modules/*/node_modules/typescript/lib/tsserver.js',
    }
    for _, pattern in ipairs(search_patterns) do
      local matches = vim.fn.glob(pattern, false, true)
      if #matches > 0 then
        tsserver_path = matches[1]
        break
      end
    end


    require('typescript-tools').setup({
      settings = {
        separate_diagnostic_server = true,
        publish_diagnostic_on = 'insert_leave',
        expose_as_code_action = {},
        tsserver_path = tsserver_path,
        tsserver_plugins = {},
        tsserver_max_memory = 8192,
        tsserver_format_options = {},
        tsserver_file_preferences = {},
        tsserver_locale = 'en',
        complete_function_calls = false,
        include_completions_with_insert_text = true,
        code_lens = 'off',
        disable_member_code_lens = true,
        jsx_close_tag = {
          enable = false,
          filetypes = { 'javascriptreact', 'typescriptreact' },
        },
      },
    })
  end,
}
