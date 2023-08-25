--------------- [Utils] ---------------

local keymap = vim.api.nvim_set_keymap
local term_opts = { silent = true }

local function map(mode, lhs, rhs, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	keymap(mode, lhs, rhs, options)
end

--------------- [Leader] ---------------

map("", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = " "


-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",


--------------- [Normal] ---------------

-- Better window navigation
map("n", "<C-Left>",  "<C-w>h")
map("n", "<C-Down>",  "<C-w>j")
map("n", "<C-Up>",    "<C-w>k")
map("n", "<C-Right>", "<C-w>l")

-- Resize with arrows
-- map("n", "<S-Down>",    ":resize +2<CR>")
-- map("n", "<S-Up>",      ":resize -2<CR>")
-- map("n", "<S-Left>",    ":vertical resize -2<CR>")
-- map("n", "<S-Right>",   ":vertical resize +2<CR>")

-- Navigate buffers
map("n", "<C-PageDown>",   ":BufferLineCycleNext<CR>")
map("n", "<C-PageUp>",     ":BufferLineCyclePrev<CR>")
map("n", "<C-S-PageDown>", ":BufferLineMoveNext<CR>")
map("n", "<C-S-PageUp>",   ":BufferLineMovePrev<CR>")
map("n", "<C-w>",          ":lua require('mini.bufremove').delete(0, false)<CR>")

-- Return from jump
-- map("n", "<S-Tab>", "<C-o>")

-- Move text up and down
map("n", "<S-Down>", "<Esc>:m .+1<CR>==")
map("n", "<S-Up>",   "<Esc>:m .-2<CR>==")

--------------- [Insert] ---------------

-- Press jk fast to enter
-- map("i", "jk", "<ESC>")

--------------- [Visual] ---------------

-- Stay in indent mode
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Move text up and down
map("v", "<S-Down>", ":move '>+1<CR>gv-gv")
map("v", "<S-Up>",   ":move '<-2<CR>gv-gv")

--------------- [Visual block] ---------------

-- Move text up and down
map("x", "<S-Down>", ":move '>+1<CR>gv-gv")
map("x", "<S-Up>",   ":move '<-2<CR>gv-gv")

--------------- [Terminal] ---------------

-- Better terminal navigation
map("t", "<C-Left>",  "<C-\\><C-N><C-w>h", term_opts)
map("t", "<C-Down>",  "<C-\\><C-N><C-w>j", term_opts)
map("t", "<C-Up>",    "<C-\\><C-N><C-w>k", term_opts)
map("t", "<C-Right>", "<C-\\><C-N><C-w>l", term_opts)

--------------- [Plugins] ---------------

-- Neotree
map("n", "<C-n>", "<cmd>Neotree toggle<cr>")

-- Symbols outline
map("n", "<C-m>", "<cmd>SymbolsOutline<cr>")
