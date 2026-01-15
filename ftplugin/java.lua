-- Java LSP configuration using nvim-jdtls
-- This runs every time you open a Java file

local jdtls = require 'jdtls'

-- Find project root directory
local root_markers = { 'gradlew', '.git', 'mvnw', 'pom.xml', 'build.gradle' }
local root_dir = require('jdtls.setup').find_root(root_markers)

if not root_dir then
  return
end

-- Get jdtls installation path from Mason
local jdtls_install = vim.fn.stdpath('data') .. '/mason/packages/jdtls'

-- Check if jdtls is actually installed
if vim.fn.isdirectory(jdtls_install) == 0 then
  vim.notify('jdtls not found in Mason. Install with :MasonInstall jdtls', vim.log.levels.WARN)
  return
end

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
}

-- Start or attach to jdtls
jdtls.start_or_attach(config)
