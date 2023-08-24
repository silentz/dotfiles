return {
    select = {
        keymaps = {
            ["ap"] = "@parameter.outer",
            ["ip"] = "@parameter.inner",
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
        },
        selection_modes = {
            -- "v" = charwise
            -- "V" = linewise
            ["@function.outer"] = "V",
            ["@function.inner"] = "V",
            ["@class.outer"] = "V",
            ["@class.inner"] = "V",
        },
    },
    move = {
        goto_next_start = {
            ["]p"] = "@parameter.outer",
            ["]f"] = "@function.outer",
            ["]c"] = "@class.outer",
        },
        goto_next_end = {

        },
        goto_previous_start = {
            ["[p"] = "@parameter.outer",
            ["[f"] = "@function.outer",
            ["[c"] = "@class.outer",
        },
        goto_previous_end = {

        }
    },
    swap = {
        swap_next = {
            ["][p"] = "@parameter.inner",
            ["][f"] = "@function.outer",
            ["][c"] = "@class.outer",
        },
        swap_previous = {
            ["[]p"] = "@parameter.inner",
            ["[]f"] = "@function.outer",
            ["[]c"] = "@class.outer",
        },
    },
}
