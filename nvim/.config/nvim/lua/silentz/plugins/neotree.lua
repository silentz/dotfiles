return function()
    local status_ok, neotree = pcall(require, "neo-tree")
    if not status_ok then
        print("ERROR", neotree)
        return
    end

    local keymaps = myrequire(".keymaps.neotree")

    neotree.setup({
        -- Close Neo-tree if it is the last window left in the tab
        close_if_last_window = true,
        popup_border_style = "rounded",
        enable_git_status = true,
        enable_diagnostics = true,
        -- used when sorting files and directories in the tree
        sort_case_insensitive = false,
        -- use a custom function for sorting files and directories in the tree
        sort_function = nil,
        default_component_configs = {
            container = {
                enable_character_fade = true,
            },
            indent = {
                indent_size = 2,
                -- extra padding on left hand side
                padding = 1,
                -- indent guides
                with_markers = false,
                indent_marker = "│",
                last_indent_marker = "└",
                highlight = "NeoTreeIndentMarker",
                -- expander config, needed for nesting files
                -- if nil and file nesting is enabled, will enable expanders
                with_expanders = nil,
                expander_collapsed = "",
                expander_expanded = "",
                expander_highlight = "NeoTreeExpander",
            },
            icon = {
                folder_closed = "",
                folder_open = "",
                folder_empty = "󰉖",
                folder_empty_open = "󰷏",
                -- The next two settings are only a fallback, if you use
                -- nvim-web-devicons and configure default icons there
                -- then these will never be used.
                default = "*",
                highlight = "NeoTreeFileIcon",
            },
            modified = {
                symbol = "[+]",
                highlight = "NeoTreeModified",
            },
            name = {
                trailing_slash = false,
                use_git_status_colors = true,
                highlight = "NeoTreeFileName",
            },
            git_status = {
                symbols = {
                    -- Change type
                    added    = "A",
                    modified = "M",
                    deleted  = "D",
                    renamed  = "R",
                    -- Status type
                    untracked = "U",
                    ignored   = "I",
                    unstaged  = "",
                    staged    = "S",
                    conflict  = "!",
                },
            },
        },
        window = {
            position = "left",
            width = "20%",
            mapping_options = {
                noremap = true,
                nowait = true,
            },
            mappings = keymaps.window,
        },
        nesting_rules = {},
        filesystem = {
            filtered_items = {
                -- when true, they will just be displayed differently than normal items
                visible = true,
                hide_dotfiles = true,
                hide_gitignored = true,
                -- only works on Windows for hidden files/directories
                hide_hidden = true,
                hide_by_name = {
                    --"node_modules"
                },
                -- uses glob style patterns
                hide_by_pattern = {
                    --"*.meta",
                    --"*/src/*/tsconfig.json",
                },
                -- remains visible even if other settings would normally hide it
                always_show = {
                    --".gitignored",
                },
                -- remains hidden even if visible is toggled to true, this overrides always_show
                never_show = {
                    --".DS_Store",
                    --"thumbs.db"
                },
            },
            -- This will find and focus the file in the active buffer every
            -- time the current file is changed while the tree is open.
            follow_current_file = {
                enabled = false,
            },
            -- when true, empty folders will be grouped together
            group_empty_dirs = false,
            -- netrw disabled, opening a directory opens neo-tree
            -- in whatever position is specified in window.position
            --   "open_current",  -- netrw disabled, opening a directory opens within the
            --                       window like netrw would, regardless of window.position
            --   "disabled",      -- netrw left alone, neo-tree does not handle opening dirs
            hijack_netrw_behavior = "open_default",
            -- This will use the OS level file watchers to detect changes
            -- instead of relying on nvim autocmd events.
            use_libuv_file_watcher = true,
            window = {
                mappings = keymaps.filesystem,
            },
        },
        buffers = {
            -- This will find and focus the file in the active buffer every
            -- time the current file is changed while the tree is open.
            follow_current_file = {
                enabled = true,
            },
            -- when true, empty folders will be grouped together
            group_empty_dirs = true,
            show_unloaded = true,
            window = {
                mappings = keymaps.buffers,
            },
        },
        git_status = {
            window = {
                position = "float",
                mappings = keymaps.git,
            },
        },
    })
end
