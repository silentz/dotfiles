local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
    return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})


null_ls.setup({
    debug = false,
    sources = {
        formatting.prettier,
        formatting.isort,
        formatting.black,
        formatting.stylua,
        formatting.gofmt,
        formatting.beautysh,
        formatting.asmfmt,
        formatting.rustfmt,
        formatting.ktlint,
        formatting.google_java_format,
        formatting.dart_format,
        formatting.clang_format.with({
            extra_args = { "-style", "{IndentWidth: 4, ColumnLimit: 300}" },
        }),
        null_ls.builtins.code_actions.gitsigns,
    },
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.formatting_sync()
                end,
            })
        end
    end,
})

