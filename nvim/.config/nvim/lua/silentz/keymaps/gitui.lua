return function(bufnr)
    local opts = { noremap = true, silent = true }
    local keymap = vim.api.nvim_buf_set_keymap
    keymap(bufnr, "t", [[<c-\>]], "<cmd>close<CR>", opts)
    -- breaks gitui inner escape keymaps, so do not use it
    -- keymap(bufnr, "t", "<esc>", "<cmd>close<CR>", opts)
end
