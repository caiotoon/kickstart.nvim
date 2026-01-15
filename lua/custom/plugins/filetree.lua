-- Unless you are still migrating, remove the deprecated commands from v1.x
vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

return {
  "nvim-neo-tree/neo-tree.nvim",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  },
  config = function ()
    require('neo-tree').setup {
      filesystem = {
        window = {
          mappings = {
            ["<space>"] = "none",  -- Disable space to avoid conflict with leader key
            -- Use <CR> (Enter) or 'o' to open files/folders
          },
        },
      },
    }
  end,
}
