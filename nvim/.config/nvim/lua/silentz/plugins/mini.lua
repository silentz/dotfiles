return function()
    local status_ok, mini_comment = pcall(require, "mini.comment")
    if not status_ok then
        print("ERROR", mini_comment)
        return
    end

    mini_comment.setup({
        mappings = myrequire(".keymaps.mini_comments"),
    })

    local status_ok, mini_trailspace = pcall(require, "mini.trailspace")
    if not status_ok then
        print("ERROR", mini_trailspace)
        return
    end

    mini_trailspace.setup({
        only_in_normal_buffers = true,
    })
end
