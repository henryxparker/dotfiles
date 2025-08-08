-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim
local function go_to_source(name)
  return function(state)
    require('neo-tree.command').execute {
      source = name,
      position = state.current_position,
      action = 'focus',
    }
  end
end

local goto_git = go_to_source 'git_status'

local goto_fs = go_to_source 'filesystem'

local show_diff = function(state)
  -- some variables. use any if you want
  local node = state.tree:get_node()
  local abs_path = node.path
  local file_name = node.name
  local is_file = node.type == 'file'
  if not is_file then
    vim.notify('Diff only for files', vim.log.levels.ERROR)
    return
  end
  -- open file
  local cc = require 'neo-tree.sources.common.commands'
  cc.open(state, function()
    -- do nothing for dirs
  end)

  require 'diffview'
  -- diffview.nvim
  vim.cmd('DiffviewOpen --selected-file=' .. abs_path)
end

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
    'TimCreasman/neo-tree-tests-source.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '\\', ':Neotree reveal_force_cwd last<CR>', desc = 'NeoTree reveal', silent = true },
    { 'g\\g', ':Neotree source=git_status reveal<CR>', desc = 'NeoTree reveal git', silent = true },
    { 'g\\f', ':Neotree source=filesystem reveal_force_cwd<CR>', desc = 'NeoTree reveal filesystem', silent = true },
  },
  opts = {
    close_if_last_window = true,
    enable_git_status = true,
    reveal_force_cwd = true,
    sources = { 'filesystem', 'git_status', 'tests' },
    window = {
      mappings = { ['\\'] = 'close_window' },
    },
    source_selector = {
      winbar = true,
      statusline = false,
      sources = {
        { source = 'filesystem' },
        -- { source = 'buffers' },
        { source = 'git_status' },
        { source = 'tests' },
      },
    },
    filesystem = {
      bind_to_cwd = true,
      group_empty_dirs = true,
      window = {
        mappings = { ['G'] = goto_git },
      },
    },
    git_status = {
      bind_to_cwd = true,
      group_empty_dirs = true,
      window = {
        mappings = {
          ['F'] = goto_fs,
          ['D'] = show_diff,
        },
      },
    },
  },
}
