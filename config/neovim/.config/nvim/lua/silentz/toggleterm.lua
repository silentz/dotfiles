local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
    return
end

toggleterm.setup({
    size = 20,
    open_mapping = [[<c-\>]],
    hide_numbers = true,
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = 2,
    start_in_insert = true,
    insert_mappings = true,
    persist_size = true,
    direction = "float",
    close_on_exit = true,
    shell = vim.o.shell,
    float_opts = {
        border = "curved",
        winblend = 0,
        highlights = {
            border = "Normal",
            background = "Normal",
        },
    },
})


vim.cmd('autocmd! TermOpen term://*')
local Terminal = require("toggleterm.terminal").Terminal


local gitui = Terminal:new({
    cmd = "gitui --polling",
    hidden = true,
    on_open = function(term)
		vim.api.nvim_buf_set_keymap(term.bufnr, "t", [[<c-\>]], "<cmd>close<CR>", { noremap = true, silent = true })
        vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<esc>", "<cmd>close<CR>", { noremap = true, silent = true })
	end,
})

function _GITUI_TOGGLE()
    gitui:toggle()
end
