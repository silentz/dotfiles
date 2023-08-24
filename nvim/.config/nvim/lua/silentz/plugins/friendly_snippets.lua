return function()
    local status_ok, snippets = pcall(require, "luasnip.loaders.from_vscode")
    if not status_ok then
        print("ERROR", snippets)
        return
    end

    snippets.lazy_load()
end
