local modules = {
    "silentz.keymaps",
    "silentz.options",
    "silentz.lazy",
    "silentz.impatient",
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
    "silentz.gitsigns",
    "silentz.toggleterm",
    "silentz.comments",
    "silentz.indents",
}


for _, name in ipairs(modules) do
    local status, err = pcall(require, name)
    if not status then
        print("Failed to load module: " .. name .. " error: " .. err)
    end
end
