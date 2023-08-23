local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end

configs.setup({
    ensure_installed = {
        -- languages
        "bash",
        "c", "cpp", "cuda",
        "go",
        "java", "kotlin",
        "javascript", "typescript", "tsx", "vue",
        "latex",
        "lua",
        "python",
        "rust",
        "solidity",

        -- Do not activate dart!!!
        -- nvim-treesitter-dart is broken!!!
        -- "dart",

        -- web
        "html", "css", "htmldjango", "http",

        -- misc
        "arduino",
        "cmake",
        "dockerfile",
        "json",
        "make",
        "markdown", "markdown_inline",
        "vim",

        -- do not install yaml!
        -- highlighting out of the box works better and does not crash!!!
        -- "yaml"
    },
    ignore_install = {}, -- List of parsers to ignore installing
    highlight = {
        enable = true, -- false will disable the whole extension
        disable = { "css" }, -- list of language that will be disabled
    },
    autopairs = {
        enable = true,
    },
    indent = { enable = true, disable = { "python", "css" } },
})
