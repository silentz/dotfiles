local modules = {
    "silentz.impatient",
    "silentz.options",
    "silentz.keymaps",
    "silentz.colorscheme",
    "silentz.cmp",
    "silentz.lsp",
    "silentz.telescope",
    "silentz.whichkey",
    "silentz.treesitter",
    "silentz.colorizer",
    "silentz.lualine",
    "silentz.symbols-outline",
    "silentz.autopairs",
    "silentz.neotree",
    "silentz.scope",
}


for _, name in ipairs(modules) do
    local status, err = pcall(require, name)
    if not status then
        print("Failed to load module: " .. name .. " error: " .. err)
    end
end
