-- Java LSP configuration using nvim-jdtls
-- This runs every time you open a Java file

local jdtls = require 'jdtls'

-- Find project root directory
local root_markers = { 'gradlew', '.git', 'mvnw', 'pom.xml', 'build.gradle' }
local root_dir = require('jdtls.setup').find_root(root_markers)

-- Get jdtls installation path from Mason
local jdtls_install = vim.fn.stdpath 'data' .. '/mason/packages/jdtls'

-- Workspace directory (unique per project)
local project_name = vim.fn.fnamemodify(root_dir, ':p:h:t')
local workspace_dir = vim.fn.stdpath 'data' .. '/jdtls-workspaces/' .. project_name

-- OS-specific configuration
local os_config = 'linux'
if vim.fn.has 'mac' == 1 then
  os_config = 'mac'
elseif vim.fn.has 'win32' == 1 then
  os_config = 'win'
end

-- jdtls configuration
local config = {
  cmd = {
    'java',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xmx1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens',
    'java.base/java.util=ALL-UNNAMED',
    '--add-opens',
    'java.base/java.lang=ALL-UNNAMED',
    '-jar',
    vim.fn.glob(jdtls_install .. '/plugins/org.eclipse.equinox.launcher_*.jar'),
    '-configuration',
    jdtls_install .. '/config_' .. os_config,
    '-data',
    workspace_dir,
  },
  root_dir = root_dir,
  settings = {
    java = {},
  },
  init_options = {
    bundles = {},
  },
  on_attach = function(client, bufnr)
    -- Helper function to set keymaps
    local map = function(keys, func, desc, mode)
      mode = mode or 'n'
      vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = 'LSP: ' .. desc })
    end

    -- Traditional keybindings (gd/gD)
    map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
    map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

    -- gr* keybindings (from init.lua global LspAttach)
    map('grn', vim.lsp.buf.rename, '[R]e[n]ame')
    map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })
    map('grr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
    map('gri', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
    map('grd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
    map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    map('gO', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')
    map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')
    map('grt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')
  end,
}

-- Start or attach to jdtls
jdtls.start_or_attach(config)
