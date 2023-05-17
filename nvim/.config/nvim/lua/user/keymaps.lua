local opts = {
  -- non-recursive mapping. For example, if you map 'j'
  -- to 'gg', then 'Q' to 'j', a recursive mapping would
  -- map 'Q' to 'gg'
  noremap = true,
  -- slient mapping will not echo on the command line
  silent = true
}

-- https://neovim.io/doc/user/api.html#nvim_set_keymap()
-- nvim_set_keymap({mode}, {lhs}, {rhs}, {*opts})
--  Sets a global mapping for the given mode.
--
--  Modes:
--    - normal_mode       = "n"
--    - insert_mode       = "i"
--    - visual_mode       = "v"
--    - visual_block_mode = "x"
--    - term_mode         = "t"
--    - command_mode      = "c"
local keymap = vim.api.nvim_set_keymap

-- Set <Space> to noop in modes
-- Normal, Visual, Select, Operator-pending
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Normal mode --

-- Window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- fix neovim changing the meaning of Y:
-- https://github.com/neovim/neovim/pull/13268
keymap("n", "Y", "yy", opts)

-- Insert mode --
keymap("i", "jj", "<ESC>", opts)
keymap("i", "kk", "<ESC>", opts)
keymap("i", "<C-a>", "<ESC>^i", opts)
keymap("i", "<C-e>", "<ESC>A", opts)

-- Visual mode --
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Terminal mode --
-- ctrl h j l k to navigate
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", opts)

-- escapes terminal mode
keymap("t", "<Esc>", "<C-\\><C-N>", opts)



vim.keymap.set('n', '<leader>dl', "<cmd>Telescope diagnostics<cr>",
  { noremap = true, silent = true, desc = "Diagnostics List" })
vim.keymap.set('n', '<leader>dn', vim.diagnostic.goto_prev, { noremap = true, silent = true, desc = "Diagnostics Next" })
vim.keymap.set('n', '<leader>dp', vim.diagnostic.goto_next, { noremap = true, silent = true, desc = "Diagnostics Prev" })
vim.keymap.set('n', '<leader>h', "<cmd>Telescope help_tags<cr>",
  { noremap = true, silent = true, desc = "Diagnostics Prev" })
