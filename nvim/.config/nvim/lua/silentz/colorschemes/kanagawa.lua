return function()
    local status_ok, colorscheme = pcall(require, "kanagawa")
    if not status_ok then
        print("ERROR", colorscheme)
        return
    end

    colorscheme.setup({})
end
