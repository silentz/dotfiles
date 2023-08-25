return function()
    local status_ok, null_ls = pcall(require, "null-ls")
    if not status_ok then
        print("ERROR", null_ls)
        return
    end

    local formatting = null_ls.builtins.formatting
    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

    null_ls.setup({
        debug = false,

        sources = {
            formatting.isort,
            formatting.black,

            formatting.stylua,
            formatting.gofmt,
            formatting.dart_format,

            formatting.ktlint,
            formatting.google_java_format,

            formatting.asmfmt,
            formatting.clang_format.with({
                extra_args = {
                    "--style",
                    "{"..
                        "IndentWidth: 4, " ..
                        "ColumnLimit: 300, "..
                        "AllowShortFunctionsOnASingleLine: Empty, "..
                        "AllowShortBlocksOnASingleLine: Always, "..
                    "}",
                },
            }),
        },

        -- NOTE uncomment this to enable autoformatting on buffer write

        -- on_attach = function(client, bufnr)
        --     if client.supports_method("textDocument/formatting") then
        --         vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        --         vim.api.nvim_create_autocmd("BufWritePre", {
        --             group = augroup,
        --             buffer = bufnr,
        --             callback = function()
        --                 vim.lsp.buf.format({bufnr=bufnr})
        --             end,
        --         })
        --     end
        -- end,
    })
end
