return function()
    local status_ok, surround = pcall(require, "nvim-surround")
    if not status_ok then
        print("ERROR", surround)
        return
    end

    surround.setup({
        keymaps = {
            normal = "ys",
            delete = "ds",
            change = "cs",
            visual = "ys",
            visual_line = false,

            -- disabled because autopair already does it in insert
            insert = false,
            insert_line = false,

            -- disabled because it is not frequently used and doesn't need a dedicated keymap
            normal_cur = false,
            normal_line = false,
            normal_cur_line = false,
        },
    })
end
