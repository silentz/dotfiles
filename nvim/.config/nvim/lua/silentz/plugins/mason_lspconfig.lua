local function findidx(table, value)
    for idx, data in pairs(table) do
        if data == value then
            return idx
        end
    end
end

local ignored_servers = {
    "dartls",
}

return function()
    local status_ok, mason_lsp = pcall(require, "mason-lspconfig")
    if not status_ok then
        print("ERROR", mason_lsp)
        return
    end

    local servers = myrequire(".plugins.shared.lsp_servers")
    for _, iserver in ipairs(ignored_servers) do
        table.remove(servers, findidx(servers, iserver))
    end

    mason_lsp.setup({
        ensure_installed = servers,
        automatic_installation = true,
    })
end
