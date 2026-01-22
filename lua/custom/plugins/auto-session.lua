return {
  'rmagatti/auto-session',
  lazy = false,

  ---enables autocomplete for opts
  ---@module "auto-session"
  ---@type AutoSession.Config
  opts = {
    suppressed_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
    -- log_level = 'debug',

    -- Close problematic UI elements before saving sessions
    pre_save_cmds = {
      function()
        -- Close neo-tree if it's open
        if pcall(require, 'neo-tree') then
          vim.cmd('Neotree close')
        end
      end,
    },

    -- Ensure proper state after session restore
    post_restore_cmds = {
      function()
        -- Give other plugins time to initialize
        vim.defer_fn(function()
          -- Force redraw to clear any stale UI
          vim.cmd('redraw!')
        end, 100)
      end,
    },

    -- Don't save these options (they can cause conflicts)
    bypass_session_save_file_types = { 'neo-tree', 'neo-tree-popup' },

    -- Auto save session on exit
    auto_save = true,
    auto_restore = true,
    auto_create = true,
  },
}
