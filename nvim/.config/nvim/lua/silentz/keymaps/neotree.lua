return {
    window = {
        -- disabled defaults
        ["s"] = false,
        ["S"] = false,
        ["<space>"] = false,

        ["<cr>"] = "open",     -- open a file in a buffer
        ["o"] = "open",        -- synonim of opening file
        ["v"] = "open_vsplit", -- open a file in a new vsplit window
        ["t"] = "open_tabnew", -- open a file in a new tab

        -- enter preview mode, which shows the current node without focusing
        ["P"] = { "toggle_preview", config = { use_float = true } },

        ["a"] = "add",                  -- add a new file to file tree
        ["A"] = "add_directory",        -- add a new directory to file tree
        ["d"] = "delete",               -- delete file/die
        ["r"] = "rename",               -- rename file/dir
        ["y"] = "copy_to_clipboard",    -- copy a file to clipboard to paste it later in tree
        ["x"] = "cut_to_clipboard",     -- cut a file to clipboard to paste it later in tree
        ["p"] = "paste_from_clipboard", -- paste a file from clipboard to current tree node
        ["c"] = "copy",                 -- copy with prompt of copied file name
        ["m"] = "move",                 -- prompt for destination and move file

        -- Neotree itself keymaps
        ["q"] = "close_window",     -- close neotree itself
        ["l"] = "open",             -- go "to the right" and open a node
        ["h"] = "close_node",       -- go "to the left" and close a node
        ["z"] = "close_all_nodes",  -- close all nodes in neotree
        -- ["Z"] = "expand_all_nodes", -- expand all nodes in tree, but it always was a pain
        ["<C-r>"] = "refresh",      -- refresh file tree
        ["R"]     = "refresh",      -- refresh file tree
        ["?"] = "show_help",    -- neotree help
        ["<"] = "prev_source",  -- prev neotree view
        [">"] = "next_source",  -- next neotree view
    },
    filesystem = {
        ["<bs>"] = "navigate_up",   -- go one level up from root dir of neotree
        ["."] = "set_root",         -- set selected directory as a new root of neotree
        ["H"] = "toggle_hidden",    -- show/hide hidden files

        -- fuzzy finder
        ["/"] = "fuzzy_finder",             -- real time fuzzy find files
        ["D"] = "fuzzy_finder_directory",   -- real time fuzzy find dirs
        ["f"] = "filter_on_submit",         -- not real time fuzzy find
        ["<c-x>"] = "clear_filter",         -- clear filter (not real time fuzzy find)

        -- git
        ["g["] = "prev_git_modified",   -- prev changed file
        ["g]"] = "next_git_modified",   -- next changed file
    },
    buffers = {
        ["<bs>"] = "navigate_up",   -- go one level up from root dir of neotree
        ["."] = "set_root",         -- set selected directory as a new root of neotree
        ["d"] = "buffer_delete",    -- delete buffer from buffers tab
    },
    git = {
        -- main git flow
        ["ga"] = "git_add_file",
        ["gc"] = "git_commit",
        ["gp"] = "git_push",

        -- shortcuts
        ["gg"] = "git_commit_and_push",
        ["gA"] = "git_add_all",

        -- undo's
        ["gu"] = "git_unstage_file",
        ["gr"] = "git_revert_file",
    },
}
