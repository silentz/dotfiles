return function()
    local status_ok, toggleterm = pcall(require, "toggleterm")
    if not status_ok then
        print("ERROR", toggleterm)
        return
    end

    toggleterm.setup({
        size = 20,
        open_mapping = [[<c-\>]],
        hide_numbers = true,
        shade_filetypes = {},
        shade_terminals = false,
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

    local status_ok, terminal = pcall(require, "toggleterm.terminal")
    if not status_ok then
        print("ERROR", terminal)
        return
    end

    vim.cmd('autocmd! TermOpen term://*')

    local gitui = terminal.Terminal:new({
        cmd = "gitui",
        hidden = true,
        on_open = function(term)
            local keymaps = myrequire(".keymaps.gitui")
            keymaps(term.bufnr)
        end,
    })

    function _GITUI_TOGGLE()
        gitui:toggle()
    end
end
