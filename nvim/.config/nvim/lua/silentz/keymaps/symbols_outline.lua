return {
    -- These keymaps can be a string or a table for multiple keys

    -- main
    close = "q",            -- close outline window
    goto_location = "<Cr>", -- move cursor to location of symbol in file
    focus_location = "o",   -- show location of symbol in file, but keep cursor on outline menu
    toggle_preview = "P",   -- preview symbol in file

    fold = "h",     -- open dropdown with nested symbols
    unfold = "l",   -- close dropdown with nested symbols

    -- misc
    hover_symbol = "<C-space>",
    rename_symbol = "r",
    fold_all = "W",
    unfold_all = "E",
    fold_reset = "R",
    -- code_actions = "a",
}
