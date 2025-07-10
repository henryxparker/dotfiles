return {
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-treesitter/nvim-treesitter',
      'stevanmilic/neotest-scala',
      'TimCreasman/neo-tree-tests-source.nvim',
    },
    config = function()
      require('neotest').setup {
        consumers = {
          neotree = require 'neotest.consumers.neotree', -- Specify our plugin as a test result consumer here:
        },
        adapters = {
          require 'neotest-scala' {
            runner = 'sbt',
            framework = 'munit',
          },
        },
      }
    end,
  },
}
