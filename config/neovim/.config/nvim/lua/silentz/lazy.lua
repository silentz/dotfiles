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
}

local plugins = {

}

require("lazy").setup(plugins, opts)
