return {
  'nvim-telescope/telescope.nvim',
  keys = {
    {
      '<leader>gf',
      function()
        local pickers = require 'telescope.pickers'
        local finders = require 'telescope.finders'
        local conf = require('telescope.config').values
        local actions = require 'telescope.actions'
        local action_state = require 'telescope.actions.state'
        local previewers = require 'telescope.previewers'

        -- Get commit hash (default to HEAD, or prompt for specific commit)
        vim.ui.input({ prompt = 'Commit (default HEAD): ' }, function(commit)
          commit = (commit == '' or commit == nil) and 'HEAD' or commit

          -- Get files from commit
          local files = vim.fn.systemlist('git diff-tree --no-commit-id --name-only -r ' .. commit)

          pickers
            .new({}, {
              prompt_title = 'Files in commit: ' .. commit,
              finder = finders.new_table {
                results = files,
              },
              sorter = conf.generic_sorter {},
              previewer = previewers.new_termopen_previewer {
                get_command = function(entry)
                  return { 'git', 'show', commit .. ':' .. entry.value }
                end,
              },
              attach_mappings = function(prompt_bufnr, map)
                -- Default action: open file for editing
                actions.select_default:replace(function()
                  actions.close(prompt_bufnr)
                  local selection = action_state.get_selected_entry()
                  vim.cmd('edit ' .. selection.value)
                end)

                -- <C-d>: Show diff of this file
                map('i', '<C-d>', function()
                  local selection = action_state.get_selected_entry()
                  actions.close(prompt_bufnr)
                  vim.cmd('Git difftool ' .. commit .. '~1 ' .. commit .. ' -- ' .. selection.value)
                end)

                -- <C-r>: Revert file to previous commit version
                map('i', '<C-r>', function()
                  local selection = action_state.get_selected_entry()
                  vim.ui.select({ 'Yes', 'No' }, { prompt = 'Revert ' .. selection.value .. ' to ' .. commit .. '~1?' }, function(choice)
                    if choice == 'Yes' then
                      vim.fn.system('git checkout ' .. commit .. '~1 -- ' .. selection.value)
                      vim.notify('Reverted: ' .. selection.value, vim.log.levels.INFO)
                      actions.close(prompt_bufnr)
                    end
                  end)
                end)

                return true
              end,
            })
            :find()
        end)
      end,
      desc = '[G]it commit [F]iles',
    },
  },
}
