local function findidx(table, value)
    for idx, data in pairs(table) do
        if data == value then
            return idx
        end
    end
end

local manually_installed = {
    dartls = true,
}

return function()
    local status_ok, mason_lsp = pcall(require, "mason-lspconfig")
    if not status_ok then
        print("ERROR", mason_lsp)
        return
    end

    local servers = myrequire(".plugins.shared.lsp_servers")
    local servers_filtered = {}

    for _, iserver in ipairs(servers) do
        if manually_installed[iserver] == nil then
            table.insert(servers_filtered, iserver)
        end
    end

    mason_lsp.setup({
        ensure_installed = servers_filtered,
        automatic_installation = true,
    })

    -- install pylsp deps
    local isort_path = vim.fn.stdpath("data") .. "/mason/packages/python-lsp-server/venv/bin/isort"
    local black_path = vim.fn.stdpath("data") .. "/mason/packages/python-lsp-server/venv/bin/black"
    local is_isort_installed = vim.fn.filereadable(isort_path)
    local is_black_installed = vim.fn.filereadable(black_path)

    if not is_black_installed or not is_isort_installed then
        vim.cmd("PylspInstall python-lsp-black pyls-isort")
    end
end
