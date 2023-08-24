return function()
    local status_ok, mason = pcall(require, "mason")
    if not status_ok then
        print("ERROR", mason)
        return
    end

    mason.setup({
        ui = {
            border = "double",
        },
    })
end
