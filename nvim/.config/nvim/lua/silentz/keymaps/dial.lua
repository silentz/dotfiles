return function(dial)
    local opts = { noremap = true, silent = true }
    local keymap = vim.api.nvim_set_keymap
    keymap("n", "<C-a>", dial.inc_normal(), opts)
	keymap("n", "<C-x>", dial.dec_normal(), opts)
	keymap("v", "<C-a>", dial.inc_visual(), opts)
	keymap("v", "<C-x>", dial.dec_visual(), opts)
	keymap("v", "g<C-a>", dial.inc_gvisual(), opts)
	keymap("v", "g<C-x>", dial.dec_gvisual(), opts)
end
