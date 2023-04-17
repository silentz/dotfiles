local servers = {
    -- Python
    "pyright",

    -- Golang
    "gopls",

    -- C/C++/Rust/Asm
    -- "clangd",
    -- "asm_lsp",
    -- "rust-analyser",

    -- Java/Kotlin
    -- "kotlin-language-server",
    -- "jdtls",

    -- Lua
    -- "lua-language-server",

    -- HTML/CSS/SCSS
    -- "html-lsp",
    -- "css-lsp",

    -- JavaScript/Vue
    -- "typescript-language-server",
    -- "vue-language-server",

    -- Latex
    -- "ltex-ls",

    -- SQL
    -- "sqlls",

    -- Docker
    -- "dockerfile-language-server",
    -- "docker-compose-language-server",

    -- Bash
    -- "bash-language-server",

    -- Dart
    "dartls",
}

local settings = {
    ui = {
        border = "none",
        icons = {
            package_installed = "◍",
            package_pending = "◍",
            package_uninstalled = "◍",
        },
    },
    log_level = vim.log.levels.INFO,
    max_concurrent_installers = 4,
}

require("mason").setup(settings)
require("mason-lspconfig").setup({
    ensure_installed = {},
    automatic_installation = false,
})

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
    return
end

local opts = {}

for _, server in pairs(servers) do
    opts = {
        on_attach = require("silentz.lsp.handlers").on_attach,
        capabilities = require("silentz.lsp.handlers").capabilities,
    }

    server = vim.split(server, "@")[1]

    local require_ok, conf_opts = pcall(require, "silentz.lsp.settings." .. server)
    if require_ok then
        opts = vim.tbl_deep_extend("force", conf_opts, opts)
    end

    lspconfig[server].setup(opts)
end
