return function(bufnr)
    local opts = { noremap = true, silent = true }
    local keymap = vim.api.nvim_buf_set_keymap
    keymap(bufnr, "t", [[<c-\>]], "<cmd>close<CR>", opts)
    keymap(bufnr, "t", "<esc>", "<cmd>close<CR>", opts)
    keymap(bufnr, "t", "q", "<cmd>close<CR>", opts)
end
