local status_ok, actions = pcall(require, "telescope.actions")
if not status_ok then
    print("ERROR", actions)
    return
end

return {
    i = {
        -- basics
        ["<esc>"] = actions.close,
        ["<C-c>"] = actions.close,
        ["<CR>"] = actions.select_default,

        -- ["<C-x>"] = actions.select_horizontal, -- open in horizontal split
        -- ["<C-v>"] = actions.select_vertical,   -- open in vertical split
        -- ["<C-t>"] = actions.select_tab,        -- open in new tab

        -- moving through results: vim flow
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,

        -- moving through results: arrows
        ["<Down>"] = actions.move_selection_next,
        ["<Up>"] = actions.move_selection_previous,

        -- scrolling: vim flow
        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,

        -- scrolling: PgUp and PgDown
        ["<PageUp>"] = actions.results_scrolling_up,
        ["<PageDown>"] = actions.results_scrolling_down,

        -- whichkey
        ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
    },

    n = {
        -- basics
        ["<esc>"] = actions.close,
        ["<C-c>"] = actions.close,
        ["<CR>"] = actions.select_default,

        -- ["<C-x>"] = actions.select_horizontal, -- open in horizontal split
        -- ["<C-v>"] = actions.select_vertical,   -- open in vertical split
        -- ["<C-t>"] = actions.select_tab,        -- open in new tab

        -- moving through results: vim flow
        ["j"] = actions.move_selection_next,
        ["k"] = actions.move_selection_previous,
        ["gg"] = actions.move_to_top,
        ["G"] = actions.move_to_bottom,

        -- moving through results: arrows
        ["<Down>"] = actions.move_selection_next,
        ["<Up>"] = actions.move_selection_previous,

        -- scrolling: vim flow
        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,

        -- scrolling: PgUp and PgDown
        ["<PageUp>"] = actions.results_scrolling_up,
        ["<PageDown>"] = actions.results_scrolling_down,

        -- whichkey
        ["?"] = actions.which_key,
    },
}
