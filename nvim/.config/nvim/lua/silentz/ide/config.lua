local SPECIAL_FILETYPES = {
    -- `true` means close, anything else means keep
    ["neo-tree"] = true,
    ["neotest-summary"] = true,
    ["cmp_menu"] = true,
}

local function verify_and_run(callback)
    local width = vim.api.nvim_win_get_width(0)
    local min_code = 120

    if width >= min_code then
        callback()
    end
end

function _ide_entity_closed(args)
    -- fetch currently open windows
    local open_wins = vim.api.nvim_list_wins()

    -- https://neovim.io/doc/user/autocmd.html#WinClosed
    local closed_win = vim.fn.expand("<amatch>")

    -- check if entity is window
    if args.type ~= "win" then
        closed_win = nil
    end

    -- if flag is true, then close all windows and exit nvim
    local close_flag = true

    -- check currently opened windows
    -- if remaining windows are SPECIAL_FILETYPES only, then close nvim
    -- otherwise keep it open
    for _, win_id in ipairs(open_wins) do
        local bufnr = vim.api.nvim_win_get_buf(win_id)
        local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")

        -- convert win_id to string, becuase <amatch> is a string
        local str_win_id = tostring(win_id)

        if str_win_id ~= closed_win and SPECIAL_FILETYPES[filetype] == nil then
            close_flag = false
        end
    end

    -- check flag and close window
    if close_flag then
        vim.cmd("qall!")
    end
end

function initial_setup()
    -- register callback on window/tab/buffer close
    -- this will help correctly close all windows if
    -- code editing is finished (all files are closed)
    vim.cmd([[ autocmd BufDelete * lua _ide_entity_closed({type="buf"}) ]])
    vim.cmd([[ autocmd TabClosed * lua _ide_entity_closed({type="tab"}) ]])
    vim.cmd([[ autocmd WinClosed * lua _ide_entity_closed({type="win"}) ]])

    -- call only if window is wide enough
    verify_and_run(
        function()
            vim.cmd("Neotree action=show source=filesystem position=left")
        end
    )
end

-- return module
return {
    initial_setup = initial_setup,
}
