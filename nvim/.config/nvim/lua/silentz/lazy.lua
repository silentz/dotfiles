-- a standart code for loading `lazy` plugin manager:
-- see: https://github.com/folke/lazy.nvim

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

-- list of plugins with their options

local plugins = {
    {
        -- Colorscheme setup
        "Shatur/neovim-ayu",
        priority = 1000,
        config = myrequire(".plugins.colorscheme"),
    },
    {
        -- Bottom ststus line
        "nvim-lualine/lualine.nvim",
        config = myrequire(".plugins.lualine"),
    },
    {
        -- File tree
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        config = myrequire(".plugins.neotree"),
        dependencies = {
            -- dependencies of neotree
            "nvim-lua/popup.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
    },
    {
        -- Telescope
        "nvim-telescope/telescope.nvim",
        config = myrequire(".plugins.telescope"),
        dependencies = {
            "nvim-telescope/telescope-media-files.nvim",
        }
    },
    {
        -- Upper line with opened files
        "akinsho/bufferline.nvim",
        version = "*",
        config = myrequire(".plugins.bufferline"),
    },
    {
        -- Provide a simple and easy way to use the interface for tree-sitter in
        -- Neovim and to provide some basic functionality such as highlighting based on it
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = { "BufReadPost", "BufNewFile" },
        config = myrequire(".plugins.treesitter"),
        dependencies = {
            -- Syntax aware text-objects, select, move, swap, and peek support
            "nvim-treesitter/nvim-treesitter-textobjects",
            -- Setting the commentstring based on the cursor location in a file
            "JoosepAlviste/nvim-ts-context-commentstring",
            "RRethy/nvim-treesitter-endwise", -- Auto add "end" in Ruby, Vims, Lua, etc.
            "windwp/nvim-ts-autotag",         -- Auto close and auto rename html tag
            {
                -- Annotation generator using treesitter
                "danymat/neogen",
                config = myrequire(".plugins.neogen"),
            },
        },
    },
    {
        -- Configurations for Neovim LSP client
        "neovim/nvim-lspconfig",
        config = myrequire(".plugins.lspconfig"),
        dependencies = {
            -- Portable package manager for Neovim to install and manage LSP
            -- servers, DAP servers, linters, and formatters.
            {
                "williamboman/mason.nvim",
                config = myrequire(".plugins.mason"),
            },
            -- Extension to mason.nvim that makes it easier to use lspconfig
            -- with mason.nvim. Supports autoinstalling LSP servers for config.
            {
                "williamboman/mason-lspconfig.nvim",
                config = myrequire(".plugins.mason_lspconfig"),
            },
            -- Auto formatting options
            {
                "jose-elias-alvarez/null-ls.nvim",
                config = myrequire(".plugins.null_ls"),
            },
        },
    },
    {
        -- General completion plugin, completion sources are installed
        -- from external repositories
        "hrsh7th/nvim-cmp",
        config = myrequire(".plugins.cmp"),
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",     -- Adds LSP completion capabilities
            "hrsh7th/cmp-buffer",       -- Adds completion source from currently opened buffers
            "hrsh7th/cmp-path",         -- Adds completion source for filesystem paths
            "hrsh7th/cmp-cmdline",      -- Adds completion for Vim's cmdline
            "hrsh7th/cmp-nvim-lua",     -- Adds source for neovim lua api
            "saadparwaiz1/cmp_luasnip", -- Adds completion source for snippets

            -- Snippet Engine
            {
                "L3MON4D3/LuaSnip",
                dependencies = {
                    {
                        "rafamadriz/friendly-snippets",
                        config = myrequire(".plugins.friendly_snippets"),
                    },
                },
            },
        },
    },
    {
        -- Autopairs for neovim
        "windwp/nvim-autopairs",
        config = myrequire(".plugins.nvim_autopairs"),
    },
    {
        -- A tree like view for symbols in Neovim using LSP
        dir = vim.fn.stdpath("config") .. "/patched/symbols-outline.nvim",
        config = myrequire(".plugins.symbols_outline"),
    },
    {
        -- Git signs
        "lewis6991/gitsigns.nvim",
        config = myrequire(".plugins.gitsigns"),
    },
    {
        -- Toggleterm
        "akinsho/toggleterm.nvim",
        config = myrequire(".plugins.toggleterm"),
    },
    {
        -- Paint #rgb and #rrggbb notations and other color formats
        -- right in text editor
        "norcalli/nvim-colorizer.lua",
        config = myrequire(".plugins.colorizer"),
    },
    {
        -- Auto highlighting other uses of the word under the cursor
        "RRethy/vim-illuminate",
        config = myrequire(".plugins.vim_illuminate"),
    },
    {
        -- Multipurpouse lib, but I use mainly for comments
        "echasnovski/mini.nvim",
        config = myrequire(".plugins.mini_comments"),
    },
    {
        -- Keymap binding tool with helper popups
        "folke/which-key.nvim",
        config = myrequire(".plugins.whichkey"),
    },
    {
        -- Visual indents in code
        "lukas-reineke/indent-blankline.nvim",
        config = myrequire(".plugins.indent_blankline"),
    },
    {
        -- Fix copy/paste behaviour in visual mode
        "silentz/nvim.nocopy-paste",
    },
    {
        -- TODO comments in code
        "folke/todo-comments.nvim",
        config = myrequire(".plugins.todo_comments"),
    },
    {
        -- Running unit-tests inside nvim
        "nvim-neotest/neotest",
        config = myrequire(".plugins.neotest"),
        dependencies = {
            "antoinemadec/FixCursorHold.nvim",

            -- adapters,
            "nvim-neotest/neotest-go",
            "nvim-neotest/neotest-python",
            "nvim-neotest/neotest-plenary",
            { dir = vim.fn.stdpath("config") .. "/untrusted/neotest-dart" },

            {
                "nvim-neotest/neotest-vim-test",
                dependencies = {
                    "vim-test/vim-test",
                },
            },
        },
    },
    {
        "iamcco/markdown-preview.nvim",
        config = myrequire(".plugins.markdown_preview"),
    },
    {
        dir = vim.fn.stdpath("config") .. "/untrusted/trailing-whitespace",
        config = myrequire(".plugins.trailing_whitespace"),
    },
    {
        dir = vim.fn.stdpath("config") .. "/untrusted/renamer.nvim",
        config = myrequire(".plugins.renamer_nvim"),
    },
}

-- list of options for lazy plugin

local options = {
    -- directory where plugins will be installed
    root = vim.fn.stdpath("data") .. "/lazy",

    -- lockfile location: i prefer not to keep it in repo
    -- to return to defaults, use: vim.fn.stdpath("config") .. "/lazy-lock.json"
    lockfile = vim.fn.stdpath("data") .. "/lazy-lock.json",

    -- state info for checker and other things
    state = vim.fn.stdpath("state") .. "/lazy/state.json",

    ---@type number? limit the maximum amount of concurrent tasks
    -- nil means no limit on concurrent tasks
    concurrency = nil,

    defaults = {
        -- should plugins be lazy-loaded?
        lazy = false,
    },

    install = {
        -- install missing plugins on startup. This doesn't increase startup time.
        missing = true,

        -- try to load one of these colorschemes when starting an installation during startup
        colorscheme = { "ayu", "habamax" },
    },

    checker = {
        -- automatically check for plugin updates
        enabled = false,

        ---@type number? set to 1 to check for updates very slowly
        concurrency = nil,

        -- get a notification when new updates are found
        notify = true,

        -- check for updates every hour
        frequency = 3600,
    },

    change_detection = {
        -- automatically check for config file changes and reload the ui
        enabled = true,

        -- get a notification when changes are found
        notify = true,
    },

    ui = {
        -- a number <1 is a percentage., >1 is a fixed size
        size = { width = 0.8, height = 0.8 },

        -- wrap the lines in the ui if they exceed the limit of window
        wrap = true,

        -- The border to use for the UI window.
        -- Accepts same border values as |nvim_open_win()|.
        border = "double",

        -- Title of plugin management window
        -- only works when border is not "none"
        title = "Lazy.nvim",

        -- Title position: "center" | "left" | "right"
        title_pos = "center",

        -- Show pills (plugin window help) on top of the Lazy window
        pills = true,

        -- leave nil, to automatically select a browser depending on your OS.
        -- If you want to use a specific browser, you can define it here
        browser = "chromium",

        -- how frequently should the ui process render events
        throttle = 20,

        custom_keys = {
            -- you can define custom key maps here.
            -- To disable one of the defaults, set it to false
        },
    },

    performance = {
        cache = {
            -- During startup, all Lua files used before VimEnter or BufReadPre
            -- are byte-compiled and cached, similar to what impatient.nvim does.
            enabled = true,
        },

        -- reset the package path to improve startup time
        reset_packpath = true,

        -- rtp here means vim.opt.rtp:
        -- it is a list of directories to be searched for these runtime files:
        --   filetype.lua	filetypes new-filetype
        --   autoload/	automatically loaded scripts autoload-functions
        --   colors/	color scheme files :colorscheme
        --   compiler/	compiler files :compiler
        --   doc/		documentation write-local-help
        --   ftplugin/	filetype plugins write-filetype-plugin
        --   indent/	indent scripts indent-expression
        --   keymap/	key mapping files mbyte-keymap
        --   lang/		menu translations :menutrans
        --   lua/		Lua plugins
        --   menu.vim	GUI menus menu.vim
        --   pack/		packages :packadd
        --   parser/	treesitter syntax parsers
        --   plugin/	plugin scripts write-plugin
        --   queries/	treesitter queries
        --   rplugin/	remote-plugin scripts
        --   spell/	spell checking files spell
        --   syntax/	syntax files mysyntaxfile
        --   tutor/	tutorial files :Tutor
        rtp = {
            -- reset the runtime path to $VIMRUNTIME and your config directory
            reset = true,

            -- @type string[] add any custom paths here that you want to includes in the rtp
            -- see vim.opt.rtp for more details
            paths = {},

            ---@type string[] list any plugins you want to disable here
            disabled_plugins = {
                -- "gzip",
                -- "zipPlugin",
            },
        },
    },

    readme = {
        -- lazy can generate helptags from the headings in markdown readme files,
        -- so ":help" works even for plugins that don't have vim docs.
        -- when the readme opens with ":help" it will be correctly displayed as markdown
        enabled = true,

        -- root path to store generated readme help docs
        root = vim.fn.stdpath("state") .. "/lazy/readme",

        -- path regexps for generating help docs
        files = { "README.md", "lua/**/README.md" },

        -- only generate markdown helptags for plugins that dont have docs
        skip_if_doc_exists = true,
    },

    build = {
        -- Plugins can provide a `build.lua` file that will be executed when the plugin
        -- is installed or updated. When the plugin spec also has a `build` command,
        -- the plugin's `build.lua` not be executed. In this case, a warning message will be shown.
        warn_on_override = true,
    },

    dev = {
        -- directory where you store your local plugin projects
        path = "~/nvim_plugins",

        -- string[] plugins that match these patterns will use your local
        -- versions instead of being fetched from GitHub
        -- example: {"folke"}
        patterns = {},

        -- fallback to git when local plugin doesn't exist
        fallback = false,
    },
}

-- load lazy.nvim and install all plugins

local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
    print("ERROR", lazy)
    return
end

lazy.setup(plugins, options)
