return function()
    local status_ok, indents = pcall(require, "indent_blankline")
    if not status_ok then
        print("ERROR", indents)
        return
    end

    -- ignore indents in these buffer types
    vim.g.indent_blankline_buftype_exclude = {
        "terminal",
        "nofile",
    }

    -- ignore indents in these filetypes
    vim.g.indent_blankline_filetype_exclude = {
        "checkhealth",
        "man",
        "help",
        "lazy",
        "Outline",
        "lspinfo",
        "neo-tree",
    }

    -- vim.opt.list = true
    -- vim.opt.listchars:append "space:⋅"
    -- vim.opt.listchars:append "space:"
    -- vim.opt.listchars:append "eol:↴"

    -- global vars
    vim.g.indentLine_enabled = 1
    vim.g.indent_blankline_char = "▏"
    vim.g.indent_blankline_context_char = "▏"
    vim.g.indent_blankline_char_blankline = "▏"
    vim.g.indent_blankline_space_char_blankline = " "
    vim.g.indent_blankline_context_char_blankline = "▏"

    vim.g.indent_blankline_use_treesitter = true
    vim.g.indent_blankline_show_first_indent_level = false
    vim.g.indent_blankline_show_trailing_blankline_indent = false

    indents.setup({
        show_current_context = true,        -- highlight current context or not
        show_current_context_start = false, -- underline first line of context or not
    })
end
