local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end

configs.setup({
    ensure_installed = {"arduino", "bash", "c", "cmake", "cpp", "python"},
  -- ensure_installed = { "arduino", "bash", "c", "cmake", "cpp", "css", "cuda",
  --                      "dart", "dockerfile", "go", "gomod", "gosum",
  --                      "html", "htmldjango", "html_tags", "http", "java",
  --                      "javascript", "json", "kotlin", "latex", "make",
  --                      "markdown", "markdown_inline", "python",
  --                      "rust", "solidity", "sql", "typescript", "vue", "yaml" },
    ignore_install = { "phpdoc" }, -- List of parsers to ignore installing
    highlight = {
        enable = true, -- false will disable the whole extension
        disable = { "css" }, -- list of language that will be disabled
    },
    autopairs = {
        enable = true,
    },
    indent = { enable = true, disable = { "python", "css" } },
})
