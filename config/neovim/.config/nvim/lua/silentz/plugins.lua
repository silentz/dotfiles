local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)
vim.g.mapleader = " "

-- load lazy

local opts = {
    defaults = { lazy = true },
    ui = { wrap = "true" },
    checker = { enabled = true },
    change_detection = { enabled = true },
    debug = false,
    performance = {
        rtp = {
            disabled_plugins = {
                -- list of disabled plugins
            },
        },
    },
}

local plugins = {
    -- core
    "folke/lazy.nvim",
    "nvim-lua/popup.nvim",
	"nvim-lua/plenary.nvim",
	"MunifTanjim/nui.nvim",
    "lewis6991/impatient.nvim",

    -- treesitter
    "nvim-treesitter/nvim-treesitter",
    "danymat/neogen",

    -- telescope
    "nvim-telescope/telescope.nvim",

    -- cmp
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lua",
    "saadparwaiz1/cmp_luasnip",

    -- lsp
    "neovim/nvim-lspconfig",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "jose-elias-alvarez/null-ls.nvim",
    "RRethy/vim-illuminate",
    "ray-x/lsp_signature.nvim",

    -- snippets
    "L3MON4D3/LuaSnip",
    "rafamadriz/friendly-snippets",

    -- colorschemes
    "projekt0n/github-nvim-theme",
    "Shatur/neovim-ayu",

    -- ui
    "nvim-lualine/lualine.nvim",
    "lukas-reineke/indent-blankline.nvim",
    "kyazdani42/nvim-web-devicons",
    "simrat39/symbols-outline.nvim",
    "nvim-neo-tree/neo-tree.nvim",

    -- random
    "akinsho/toggleterm.nvim",
    "lewis6991/gitsigns.nvim",
    "norcalli/nvim-colorizer.lua",
    "windwp/nvim-autopairs",
    "folke/which-key.nvim",
    "echasnovski/mini.nvim",
    "silentz/nvim.nocopy-paste",
}

require("lazy").setup(plugins, opts)
