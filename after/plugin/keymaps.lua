-- Additional telescope keymaps (<leader>f* aliases for common searches)
-- Moved from lua/custom/plugins/telescope-remap.lua to avoid re-declaring the telescope plugin spec.

vim.keymap.set('n', '<leader>ff', function() require('telescope.builtin').find_files() end, { desc = '[F]ind [F]iles' })
vim.keymap.set('n', '<leader>fg', function() require('telescope.builtin').live_grep() end, { desc = '[F]ind by [G]rep' })
vim.keymap.set('n', '<leader>fb', function() require('telescope.builtin').buffers() end, { desc = '[F]ind [B]uffers' })
vim.keymap.set('n', '<leader>fh', function() require('telescope.builtin').help_tags() end, { desc = '[F]ind [H]elp' })
vim.keymap.set('n', '<leader>fu', function() require('telescope.builtin').lsp_references() end, { desc = '[F]ind [U]sages/references' })

-- Directory-scoped live grep: pick a directory first, then grep within it
-- Moved from lua/custom/plugins/telescope-directory-grep.lua to avoid re-declaring the telescope plugin spec.
vim.keymap.set('n', '<leader>sD', function()
  local pickers = require('telescope.pickers')
  local finders = require('telescope.finders')
  local conf = require('telescope.config').values
  local actions = require('telescope.actions')
  local action_state = require('telescope.actions.state')

  -- Determine which command to use for finding directories
  local find_cmd
  if vim.fn.executable('fd') == 1 then
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
      sorter = conf.generic_sorter({}),
      previewer = conf.file_previewer({}),
      attach_mappings = function(prompt_bufnr, map)
        local function select_directory()
          local selection = action_state.get_selected_entry()
          actions.close(prompt_bufnr)

          if selection then
            local dir = selection.path

            -- Open live_grep confined to the selected directory
            vim.schedule(function()
              require('telescope.builtin').live_grep({
                prompt_title = 'Live Grep in: ' .. dir,
                search_dirs = { dir },
              })
            end)
          end
        end

        map('i', '<CR>', select_directory)
        map('n', '<CR>', select_directory)

        return true
      end,
    })
    :find()
end, { desc = '[S]earch in [D]irectory (pick dir first)' })

-- Set path_display to 'smart' after telescope loads
vim.api.nvim_create_autocmd('VimEnter', {
  once = true,
  callback = function()
    vim.schedule(function()
      local ok, config = pcall(require, 'telescope.config')
      if ok then
        config.values.path_display = { 'smart' }
      end
    end)
  end,
})
