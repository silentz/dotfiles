function _SIGNATURE_HELP()
    vim.lsp.buf.hover()
    vim.lsp.buf.signature_help()
end

return function(bufnr)
    local status_ok, wk = pcall(require, "which-key")
    if not status_ok then
        print("ERROR", wk)
        return
    end

    -- normal mode
    wk.register({
		buffer = bufnr,
		g = {
			name = "+goto",
			D = { "<cmd>Telescope lsp_declarations     initial_mode=normal<cr>", "LSP Declaration" },
			d = { "<cmd>Telescope lsp_definitions      initial_mode=normal<cr>", "LSP Definition" },
			i = { "<cmd>Telescope lsp_implementations  initial_mode=normal<cr>", "LSP Implementations" },
			t = { "<cmd>Telescope lsp_type_definitions initial_mode=normal<cr>", "LSP Type Definitions" },
			x = { "<cmd>Telescope lsp_references       initial_mode=normal<cr>", "LSP References" },
			l = { "<cmd>lua vim.diagnostic.open_float({ border = 'rounded' })<CR>", "LSP Diagnostic" },
            r = { "<cmd>lua require('renamer').rename()<cr>", "LSP Rename" },
		},

		["<C-s>"] = { "<cmd>lua _SIGNATURE_HELP()<cr>", "LSP Signature Help" },
		["<C-e>"] = { "<cmd>lua vim.diagnostic.open_float({ border = 'rounded' })<CR>", "LSP Diagnostic" },
		["<C-r>"] = { "<cmd>lua require('renamer').rename()<cr>", "LSP Rename" },

		["[d"] = { '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', "LSP Prev Diagnostic" },
		["]d"] = { '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', "LSP Next Diagnostic" },
	})

    -- insert mode
	wk.register({
        buffer = bufnr,
		["<C-s>"] = { "<cmd>lua _SIGNATURE_HELP()<cr>", "Signature Help" },
		["<C-e>"] = { "<cmd>lua vim.diagnostic.open_float({ border = 'rounded' })<CR>", "LSP Diagnostic" },
		["<C-r>"] = { "<cmd>lua require('renamer').rename()<cr>", "LSP Rename" },
	}, { mode = "i" })
end
