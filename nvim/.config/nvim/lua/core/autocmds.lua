-----------------------------------------------------------
-- Autocommand functions
-----------------------------------------------------------

-- Define autocommands with Lua APIs
-- See: :h api-autocmd, :h augroup
-- https://neovim.io/doc/user/autocmd.html

local augroup = vim.api.nvim_create_augroup -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd -- Create autocommand

-----------------------------------------------------------
-- Local keymaps
-----------------------------------------------------------

local map = vim.keymap.set

autocmd('BufEnter', {
  pattern = '*.http',
  callback = function(event)
    map('n', '<leader>rc', '<cmd>Rest run<CR>', { buffer = event.buffer })
  end,
})
