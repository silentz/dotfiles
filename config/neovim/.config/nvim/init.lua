local modules = {
    "silentz.options",
    "silentz.keymaps",
    "silentz.colorscheme",
    "silentz.cmp",
    "silentz.lsp",
}


for _, name in ipairs(modules) do
    local status, err = pcall(require, name)
    if not status then
        print("Failed to load module: " .. name .. " error: " .. err)
    end
end
