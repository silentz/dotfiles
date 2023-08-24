return function()
    local status_ok, telescope = pcall(require, "telescope")
    if not status_ok then
        print("ERROR", telescope)
        return
    end

    local keymaps = myrequire(".keymaps.telescope")

    telescope.setup({
        defaults = {
            prompt_prefix = "> ",
            selection_caret = "> ",
            path_display = { "smart" },
            mappings = keymaps,
        },
        pickers = {},
        extensions = {
            media_files = {
                filetypes = { "png", "webp", "jpg", "jpeg", "pdf" },
                find_cmd = "rg",
            },
        },
    })
end
