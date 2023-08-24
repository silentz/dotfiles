return function()
    local status_ok, cmp = pcall(require, "cmp")
    if not status_ok then
        print("ERROR", cmp)
        return
    end

    local status_ok, cmp_keymaps = pcall(myrequire, ".keymaps.cmp")
    if not status_ok then
        print("ERROR", cmp_keymaps)
        return
    end

    local source_to_menu = {
        nvim_lsp_signature_help = "[lsp sign]",
        nvim_lsp                = "[lsp]",
        nvim_lua                = "[nvim lua]",
        luasnip                 = "[snippet]",
        buffer                  = "[buffer]",
        path                    = "[path]",
    }

    cmp.setup({
        -- REQUIRED - you must specify a snippet engine
        snippet = {
            expand = function(args)
                local status_ok, luasnip = pcall(require, "luasnip")
                if not status_ok then
                    print("ERROR", luasnip)
                    return
                end
                luasnip.lsp_expand(args.body)
            end,
        },
        formatting = {
            fields = { "abbr", "kind", "menu" },
		    format = function(entry, vim_item)
		        vim_item.menu = source_to_menu[entry.source.name]
		        return vim_item
            end,
        },
        mapping = cmp.mapping.preset.insert(cmp_keymaps),
        sources = cmp.config.sources({
            { name = "nvim_lsp" },
            { name = "nvim_lua" },
            { name = "luasnip" },
            { name = "buffer" },
            { name = "path" },
        }, {
            { name = 'buffer' },
        }),
        confirm_opts = {
            behavior = cmp.ConfirmBehavior.Replace,
            select = false,
        },
        window = {
            documentation = {
                border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
            },
        },
        experimental = {
            ghost_text = false,
            native_menu = false,
        },
    })

    cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
            { name = 'buffer' },
        },
    })

    cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
            { name = 'path' },
        }, {
            { name = 'cmdline' }
        })
    })
end
