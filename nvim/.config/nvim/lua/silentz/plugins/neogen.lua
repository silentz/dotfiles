return function()
    local status_ok, neogen = pcall(require, "neogen")
    if not status_ok then
        print("ERROR", neogen)
        return
    end

    neogen.setup({
        enabled = true,
        snippet_engine = "luasnip",
	    languages = {
            python = {
			    template = {
				    annotation_convention = "google_docstrings",
			    },
		    },
            lua = {
                template = {
                    annotation_convention = "ldoc",
                },
            },
	    },
    })
end
