return {
  'nvim-telescope/telescope.nvim',
  keys = {
    {
      '<leader>sD',
      function()
        local pickers = require 'telescope.pickers'
        local finders = require 'telescope.finders'
        local conf = require('telescope.config').values
        local actions = require 'telescope.actions'
        local action_state = require 'telescope.actions.state'
        local entry_display = require 'telescope.pickers.entry_display'
        local make_entry = require 'telescope.make_entry'

        -- Determine which command to use for finding directories
        local find_cmd
        if vim.fn.executable 'fd' == 1 then
          find_cmd = { 'fd', '--type', 'd', '--hidden', '--exclude', '.git', '--strip-cwd-prefix' }
        else
          -- Use find with sed to strip ./ prefix (works on both Linux and macOS)
          find_cmd = { 'sh', '-c', 'find . -type d -not -path "*/.git/*" -not -name ".git" | sed "s|^./||" | grep -v "^\\.$"' }
        end

        pickers
          .new({}, {
            prompt_title = 'Select Directory for Live Grep',
            finder = finders.new_oneshot_job(find_cmd, {
              entry_maker = function(line)
                -- Skip empty lines (current directory)
                if line == '' or line == '.' then
                  return nil
                end
                return {
                  value = line,
                  display = line,
                  ordinal = line,
                  path = line,
                }
              end,
            }),
            sorter = conf.generic_sorter {},
            previewer = conf.file_previewer {},
            attach_mappings = function(prompt_bufnr, map)
              local function select_directory()
                local selection = action_state.get_selected_entry()
                actions.close(prompt_bufnr)

                if selection then
                  local dir = selection.path

                  -- Open live_grep confined to the selected directory
                  vim.schedule(function()
                    require('telescope.builtin').live_grep {
                      prompt_title = 'Live Grep in: ' .. dir,
                      search_dirs = { dir },
                    }
                  end)
                end
              end

              map('i', '<CR>', select_directory)
              map('n', '<CR>', select_directory)

              return true
            end,
          })
          :find()
      end,
      desc = '[S]earch in [D]irectory (pick dir first)',
    },
  },
}
