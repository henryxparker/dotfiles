-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '\\', ':Neotree reveal_force_cwd<CR>', desc = 'NeoTree reveal', silent = true },
  },
  opts = {
    close_if_last_window = true,
    enable_git_status = true,
    reveal_force_cwd = true,
    filesystem = {
      bind_to_cwd = true,
      group_empty_dirs = true,
      window = {
        mappings = {
          ['\\'] = 'close_window',
        },
      },
    },
    source_selector = {
      winbar = false,
      statusline = false,
      sources = {
        { source = 'filesystem' },
        -- { source = 'buffers' },
        { source = 'git_status' },
      },
    },
  },
}
