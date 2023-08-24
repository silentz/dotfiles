return function()
    local status_ok, symbols_outline = pcall(require, "symbols-outline")
    if not status_ok then
        print("ERROR", symbols_outline)
        return
    end

    local keymaps = myrequire(".keymaps.symbols_outline")

    symbols_outline.setup({
        -- MY OWN MODIFICATION of plugin
        -- a function to open outline window
        win_open_command = "lua _ide_open_symbols_window()",

        -- Whether to highlight the currently hovered symbol (high cpu usage)
        highlight_hovered_item = false,

        -- Whether to show outline guides
        show_guides = true,

        -- Show a preview of the code on hover
        auto_preview = false,

        -- Where to open the split window (right or left)
        position = 'right',

        -- Width of window (as a % or columns based on relative_width)
        width = 30, -- 20%

        -- Whether width of window is set relative to existing windows
        relative_width = true,

        -- Whether to automatically close the window after selection
        auto_close = false,

        -- Shows numbers with the outline
        show_numbers = false,

        -- Shows relative numbers with the outline
        show_relative_numbers = false,

        -- Shows extra details with the symbols (lsp dependent)
        show_symbol_details = true,

        -- Background color of the preview window
        --   * FocusedSymbol            - Highlight of the focused symbol
        --   * Pmenu                    - Highlight of the preview popup windows
        --   * SymbolsOutlineConnector  - Highlight of the table connectors
        --   * Comment                  - Highlight of the info virtual text
        preview_bg_highlight = 'Pmenu',

        -- Depth past which nodes will be folded by default
	    autofold_depth = nil,

        -- Automatically unfold hovered symbol
        auto_unfold_hover = true,

        -- Markers to denote foldable symbol’s status
        fold_markers = { '', ''  },

        -- Whether to wrap long lines, or let them flow off the window
        wrap = true,

        -- Which keys do what
        keymaps = keymaps,

        -- Which lsp clients to ignore
        lsp_blacklist = {},

        -- Which symbols to ignore
        symbol_blacklist = {},

        -- Icon and highlight config for symbol icons
        symbols = {
            -- base
            Variable      = { icon = "var",      hl = "@constant" },
            Function      = { icon = "func",     hl = "@function" },
            Class         = { icon = "class",    hl = "@type" },
            Struct        = { icon = "struct",   hl = "@type" },
            Method        = { icon = "func",     hl = "@method" },
            Interface     = { icon = "iface",    hl = "@type" },
            Constant      = { icon = "const",    hl = "@constant" },
            Constructor   = { icon = "init",     hl = "@constructor" },
            Property      = { icon = "prop",     hl = "@method" },
            Field         = { icon = "field",    hl = "@field" },

            -- enums
            Enum          = { icon = "enum",   hl = "@type" },
            EnumMember    = { icon = "value",  hl = "@field" },

            -- packages
            File          = { icon = "file",        hl = "@text.uri" },
            Module        = { icon = "module",      hl = "@namespace" },
            Namespace     = { icon = "namespace",   hl = "@namespace" },
            Package       = { icon = "package",     hl = "@namespace" },
            Component     = { icon = "component",   hl = "@function" },
            Fragment      = { icon = "fragment",    hl = "@constant" },

            -- types
            String        = { icon = "str",    hl = "@string" },
            Number        = { icon = "num",    hl = "@number" },
            Array         = { icon = "arr",    hl = "@constant" },
            Object        = { icon = "obj",    hl = "@type" },
            Boolean       = { icon = "bool",   hl = "@boolean" },
            Null          = { icon = "NULL",   hl = "@type" },

            -- misc
            Key           = { icon = "key",         hl = "@type" },
            Event         = { icon = "event",       hl = "@type" },
            Operator      = { icon = "operator",    hl = "@operator" },
            TypeParameter = { icon = "typeparam",   hl = "@parameter" },
        },
    })
end
