return function()
    local status_ok, colorscheme = pcall(require, "ayu")
    if not status_ok then
        print("ERROR", colorscheme)
        return
    end

    colorscheme.setup({
        mirage = false,
        overrides = {},
    })
end
