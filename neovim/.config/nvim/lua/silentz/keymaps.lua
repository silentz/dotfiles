
-- Modes
--   normal_mode = "n"
--   insert_mode = "i"
--   visual_mode = "v"
--   visual_block_mode = "x"
--   command_mode = "c"
--   terminal_mode = "t"


local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Insert --
-- Reload file
keymap("i", "<C-r>", "<Esc>:e<CR>a", opts)

-- Undo
keymap("i", "<C-z>", "<Esc>:u<CR>a", opts)

-- Normal --
-- Better window navigation
keymap("n", "<C-Left>",  "<C-w>h", opts)
keymap("n", "<C-Down>",  "<C-w>j", opts)
keymap("n", "<C-Up>",    "<C-w>k", opts)
keymap("n", "<C-Right>", "<C-w>l", opts)

-- Move text up and down
keymap("n", "<S-Down>", "<Esc>:m .+1<CR>==", opts)
keymap("n", "<S-Up>",   "<Esc>:m .-2<CR>==", opts)

-- Reload file
keymap("n", "<C-r>", "<Esc>:e<CR>", opts)

-- Undo
keymap("n", "<C-z>", "<Esc>:u<CR>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<S-Down>", ":m .+1<CR>==", opts)
keymap("v", "<S-Up>",   ":m .-2<CR>==", opts)

-- Normal text pasting mode
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "<S-Down>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<S-Up>",   ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
keymap("t", "<C-Left>",  "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-Down>",  "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-Up>",    "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-Right>", "<C-\\><C-N><C-w>l", term_opts)

-- Telescope
-- Better grep
keymap("n", "<C-f>", "<cmd>Telescope live_grep<cr>", opts)
keymap("n", "<C-c>", "<cmd>Neogen<cr>", opts)

-- Outline symbols
keymap("n", "<C-q>", "<cmd>SymbolsOutline<cr>", opts)

-- Tabs
keymap("n", "<C-t>", "<cmd>tabnew<cr>", opts)
keymap("n", "<C-PageUp>", "<cmd>tabprevious<cr>", opts)
keymap("n", "<C-PageDown>", "<cmd>tabnext<cr>", opts)

-- Neotree
keymap("n", "<C-n>", "<cmd>NeoTreeRevealToggle<cr>", opts)