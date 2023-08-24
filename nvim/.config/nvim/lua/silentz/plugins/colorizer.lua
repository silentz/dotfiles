return function()
    local status_ok, colorizer = pcall(require, "colorizer")
    if not status_ok then
        print("ERROR", colorizer)
        return
    end
    colorizer.setup()
end
