local diffclose = function()
  vim.cmd [[DiffviewClose]]
end
return {
  {
    'kdheepak/lazygit.nvim',
    lazy = false,
    cmd = {
      'LazyGit',
      'LazyGitConfig',
      'LazyGitCurrentFile',
      'LazyGitFilter',
      'LazyGitFilterCurrentFile',
    },
    -- optional for floating window border decoration
    dependencies = {
      'nvim-telescope/telescope.nvim',
      'nvim-lua/plenary.nvim',
    },
    keys = {
      { '<leader>lg', '<cmd>LazyGit<cr>', desc = 'LazyGit' },
    },
    config = function()
      require('telescope').load_extension 'lazygit'
    end,
  },
  {
    'sindrets/diffview.nvim',
    keys = {
      { '<leader>dv', '<cmd>DiffviewOpen<cr>', desc = 'Open [D]iff[v]iew' },
    },
    opts = {
      keymaps = {
        file_panel = {
          { 'n', 'q', diffclose, { desc = 'Close Diffview' } },
        },
      },
    },
  },
  { 'tpope/vim-fugitive' },
}
