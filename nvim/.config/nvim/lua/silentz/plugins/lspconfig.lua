local function local_on_attach(client, bufnr)
    -- add lsp keymaps
    local lspkeymaps = myrequire(".keymaps.lsp")
    lspkeymaps(bufnr)
end

local function setup_diagnostics()
    local signs = {
		{ name = "DiagnosticSignError", text = "e" },
		{ name = "DiagnosticSignWarn",  text = "w" },
		{ name = "DiagnosticSignHint",  text = "h" },
		{ name = "DiagnosticSignInfo",  text = "i" },
	}

	for _, sign in ipairs(signs) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
	end

	local config = {
		virtual_text = false,
        signs = {
			active = signs,
		},
		float = {
			focusable = false,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
	}

	vim.diagnostic.config(config)
end

return function()
    local status_ok, lspconfig = pcall(require, "lspconfig")
    if not status_ok then
        print("ERROR", lspconfig)
        return
    end

    local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
    if not status_ok then
        print("ERROR", cmp_nvim_lsp)
        return
    end

    -- set border for :LspInfo window
    local status_ok, lsp_win = pcall(require, "lspconfig.ui.windows")
    if not status_ok then
        print("ERROR", lsp_win)
        return
    else
        lsp_win.default_options.border = "double"
    end

    local servers = myrequire(".plugins.shared.lsp_servers")
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

    setup_diagnostics()

    for _, server in ipairs(servers) do
        lspconfig[server].setup({
		    capabilities = capabilities,
		    on_attach = local_on_attach,
	    })
    end
end
