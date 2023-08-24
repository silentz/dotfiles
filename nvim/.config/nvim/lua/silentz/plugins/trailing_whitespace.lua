return function()
    local status_ok, trw = pcall(require, "trailing-whitespace")
    if not status_ok then
        print("ERROR", trw)
        return
    else
        trw.setup()
    end
end
