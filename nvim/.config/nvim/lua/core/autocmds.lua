-----------------------------------------------------------
-- Autocommand functions
-----------------------------------------------------------

-- Define autocommands with Lua APIs
-- See: :h api-autocmd, :h augroup
-- https://neovim.io/doc/user/autocmd.html

local augroup = vim.api.nvim_create_augroup -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd -- Create autocommand

-----------------------------------------------------------
-- Basic autocommands
-----------------------------------------------------------
-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-----------------------------------------------------------
-- Local keymaps
-----------------------------------------------------------

local map = vim.keymap.set

autocmd('BufEnter', {
  pattern = '*.http',
  callback = function(event)
    map('n', '<leader>rc', '<cmd>Rest run<CR>', { buffer = event.buffer })
    map('n', '<leader>re', '<cmd>Rest env select<CR>', { buffer = event.buffer })
  end,
})

