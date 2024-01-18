return function()
    local status_ok, indents = pcall(require, "ibl")
    if not status_ok then
        print("ERROR", indents)
        return
    end

    indents.setup({
        enabled = true,
        debounce = 200,
        indent = {
            char = "▏",
            smart_indent_cap = true,
            priority = 1,
        },
        whitespace = {
            remove_blankline_trail = true,
        },
        scope = {
            enabled = true,
            show_start = false,
            show_end = false,
            show_exact_scope = true,
        },
        exclude = {
            filetypes = {
                "checkhealth",
                "man",
                "help",
                "lazy",
                "lspinfo",
                "neo-tree",
            },
            buftypes = {
                "terminal",
                "nofile",
            },
        },
    })
end
