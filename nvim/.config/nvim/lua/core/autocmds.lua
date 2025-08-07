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

-----------------------------------------------------------
-- OSC7
-----------------------------------------------------------

-- vim.api.nvim_create_autocmd({ 'TermRequest' }, {
--   callback = function(e)
--     if string.sub(vim.v.termrequest, 1, 4) == '\x1b]7;' then
--       local dir = string.gsub(vim.v.termrequest, '\x1b]7;file://[^/]*', '')
--       if vim.fn.isdirectory(dir) == 0 then
--         return
--       end
--       vim.api.nvim_buf_set_var(e.buf, 'last_osc7_payload', dir)
--       if vim.api.nvim_get_current_buf() == e.buf then
--         vim.cmd.cd(dir)
--       end
--     end
--   end,
-- })
-- vim.api.nvim_create_autocmd({ 'bufenter', 'winenter', 'dirchanged' }, {
--
--   callback = function(e)
--     if vim.b.last_osc7_payload ~= nil and vim.fn.isdirectory(vim.b.last_osc7_payload) == 1 then
--       vim.cmd.cd(vim.b.last_osc7_payload)
--     end
--   end,
-- })
--
-- -- Update OSC7 for terminal emulator
-- local function update_osc7()
--   local cwd = vim.fn.getcwd()
--   local uri = 'file://' .. vim.fn.hostname() .. cwd
--   io.stdout:write('\27]7;' .. uri .. '\27\\')
-- end
--
-- -- Update OSC7 when CWD is changed
-- vim.api.nvim_create_autocmd('DirChanged', {
--   callback = update_osc7,
-- })
--
-- -- Send OSC 7 on startup in case Neovim was launched with a different CWD
-- update_osc7()
