-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- n => normal mode
-- c => command mode
-- i => insert mode
-- v => visual mode

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- disable due to conflict with ctrl + backspace
vim.g.nvim_tree_bindings = {
  ["<C-h>"] = "<NOP>", -- Disable scroll backward
  ["<C-f>"] = "<NOP>", -- Disable scroll forward
}

-- Copy and Paste
map({ "n", "v" }, "<C-c>", '"+y', opts) -- Ctrl+C to copy
map({ "n", "v" }, "<C-v>", '"+p', opts) -- Ctrl+V to paste
map("i", "<C-v>", "<C-r>+", opts) -- Ctrl+V paste in insert mode
--map("i", "<C-c>", '<Esc>"+yyi', opts) -- Ctrl+C copy current line in insert mode

-- Select All
map("n", "<C-a>", "ggVG", opts)

-- Toggle wrap (Alt+z)
map("n", "<A-z>", ":set wrap!<CR>", opts)

-- Ctrl + Backspace
map("i", "<C-h>", "<C-w>", opts)
map("n", "<C-h>", "<NOP>", opts) -- NOP => no operation
map("c", "<C-h>", "<NOP>", opts)

-- Move lines
map("n", "<A-j>", ":m .+1<CR>==", opts)
map("n", "<A-k>", ":m .-2<CR>==", opts)
map("i", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
map("i", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)

-- Save file
map("n", "<C-s>", ":w<CR>", opts)
map("i", "<C-s>", "<Esc>:w<CR>a", opts) -- save and stay in insert mode
