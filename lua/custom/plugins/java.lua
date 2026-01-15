-- Java LSP and Build Tool Support
return {
  -- nvim-jdtls: Eclipse JDT Language Server integration
  {
    'mfussenegger/nvim-jdtls',
    ft = 'java',
  },

  -- maven.nvim: Maven integration
  {
    'eatgrass/maven.nvim',
    cmd = { 'Maven', 'MavenExec' },
    dependencies = 'nvim-lua/plenary.nvim',
    config = function()
      require('maven').setup {
        executable = './mvnw',
      }
    end,
  },
}
