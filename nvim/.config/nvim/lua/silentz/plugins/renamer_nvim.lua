return function()
    local status_ok, renamer = pcall(require, "renamer")
    if not status_ok then
        print("ERROR", renamer)
        return
    end

    renamer.setup()
end
