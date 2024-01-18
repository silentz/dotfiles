local parsers = {
    -- C/C++/Cuda
    "c", "cmake", "cpp", "cuda", "ninja",

    -- Python
    "python",

    -- Golang
    "go", "gomod", "gosum", "gowork",

    -- Dart
    "dart",

    -- Java
    "java", "kotlin", "scala",

    -- Lua
    "lua", "luadoc",

    -- Web
    "css", "graphql", "html", "http",
    "javascript", "scss", "svelte",
    "typescript", "vue",

    -- Latex
    "bibtex", "latex",

    -- Solidity
    "solidity",

    -- utils
    "bash",
    "dockerfile",
    "markdown",
    "markdown_inline",
    "regex",
    "sql",
    "terraform",
    "toml",
    "json",
    "todotxt",
    "vim",

    -- DO NOT UNCOMMENT: does not work with jinja in yaml
    -- "yaml",
}

return function()
    local status_ok, treesitter = pcall(require, "nvim-treesitter.configs")
    if not status_ok then
        print("ERROR", treesitter)
        return
    end

    local keymaps = myrequire(".keymaps.treesitter")

    treesitter.setup({
        sync_install = false,
        ensure_installed = parsers,
        highlight = {
            enable = true,
            disable = {},
        },
        indent = {
            enable = true,
        },
        context_commentstring = {
            enable = true,
            enable_autocmd = false,
        },
        matchup = {
            enable = true,
        },
        endwise = {
            enable = true,
        },
        autotag = {
            enable = true,
        },
        textobjects = {
            select = {
                enable = true,
                -- Automatically jump forward to textobj, similar to targets.vim
                lookahead = true,
                keymaps = keymaps.select.keymaps,
                selection_modes = keymaps.select.selection_modes,
            },
            move = {
                enable = true,
                set_jumps = true, -- whether to set jumps in the jumplist
                goto_next_start = keymaps.move.goto_next_start,
                goto_next_end = keymaps.move.goto_next_end,
                goto_previous_start = keymaps.goto_previous_start,
                goto_previous_end = keymaps.goto_previous_end,
            },
            swap = {
                enable = true,
                swap_next = keymaps.swap.swap_next,
                swap_previous = keymaps.swap.swap_prev,
            },
        },
    })
end
