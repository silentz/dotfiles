return function()
    local status_ok, bufferline = pcall(require, "bufferline")
    if not status_ok then
        print("ERROR", bufferline)
        return
    end

    bufferline.setup({
        options = {
            tab_size = 10,
            mode = "buffers",
            show_buffer_close_icons = false,
            show_close_icon = false,
            offsets = {
                {
                    -- an offset for neotree
                    filetype = "neo-tree",
                    text = "File Explorer",
                    text_align = "center",
                    separator = true,
                },
                {
                    filetype = "neotest-summary",
                    text = "Tests",
                    text_align = "center",
                    separator = true,
                },
            },
        },
        highlights = {
            buffer_selected = {
                bold = true,
                italic = false,
            },
            tab_selected = {
                fg = { attribute = "fg", highlight = "Normal" },
                bold = true,
                italic = false,
            },
        },
    })
end
