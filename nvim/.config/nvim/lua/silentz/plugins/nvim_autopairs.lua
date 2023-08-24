return function()
    local status_ok, autopairs = pcall(require, "nvim-autopairs")
    if not status_ok then
        print("ERROR", autopairs)
        return
    end

    autopairs.setup({
        disable_filetype = { "TelescopePrompt" },
        check_ts = true,
        ts_config = {
            lua = { "string", "source" },
            javascript = { "string", "template_string" },
        },
    })

    local cmp_exists, cmp = pcall(require, "cmp")
    if cmp_exists then
        local status_ok, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")
        if status_ok then
            cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
        else
            print("ERROR", cmp_autopairs)
        end
    end
end
