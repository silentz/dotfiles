local status_ok, cmp = pcall(require, "cmp")
if not status_ok then
    print("ERROR", cmp)
    return
end

local function tab_func(fallback)
    if cmp.visible() then
        cmp.select_next_item()
    else
        fallback()
    end
end

local function shift_tab_func(fallback)
    if cmp.visible() then
        cmp.select_prev_item()
    else
        fallback()
    end
end

return {
    ['<CR>'] = cmp.mapping.confirm({ select = true }),

    ["<Tab>"]   = cmp.mapping(tab_func,       { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(shift_tab_func, { "i", "s" }),

    ["<Up>"]   = cmp.mapping.select_prev_item(),
    ["<Down>"] = cmp.mapping.select_next_item(),
    ["<C-k>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
    ["<C-j>"] = cmp.mapping(cmp.mapping.scroll_docs(1),  { "i", "c" }),

    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(),  { "i", "c" }),
    ["<C-q>"] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
    }),

    -- disabled options of vanilla cmp
    ["<C-n>"]  = cmp.config.disable,
    ["<C-p>"]  = cmp.config.disable,
    ["<C-y>"]  = cmp.config.disable,
}
