local _ide_mode = "none" -- [none, partial, full]

local SPECIAL_FILETYPES = {
     -- `true` means close, anything else means keep
    ["neo-tree"] = true,
    ["Outline"] = true,
    ["neotest-summary"] = true,
    ["cmp_menu"] = true,
}

local function verify_and_run(callback)
    local width = vim.api.nvim_win_get_width(0)
    local height = vim.api.nvim_win_get_height(0)
    local min_code = 120

    if width >= min_code then
        callback()
    end
end

function on_lsp_attach(lsp_bufnr)
    -- if current buffer is equal to lsp attached buffer
    -- then update document_symbols window
    -- P.S if many buffers are opened quickly, we cannot
    -- guess which LSP client will load faster, that is
    -- why we need to match buffers before updating document_symbols
    if _ide_mode == "full" then
        if vim.fn.bufnr('%') == lsp_bufnr then
            verify_and_run(
                function()
                    vim.cmd("SymbolsOutlineOpen")
                end
            )
        end
    end
end

function _ide_entity_closed(args)
    -- fetch currently open windows
    local open_wins = vim.api.nvim_list_wins()

    -- https://neovim.io/doc/user/autocmd.html#WinClosed
    local closed_win = vim.fn.expand("<amatch>")

    -- check if entity is window callback
    if args.type ~= "win" then
        closed_win = nil
    end

    -- if flag is true, then close all windows and exit nvim
    local close_flag = true

    -- if opened windows are neotree or symbols outline - close them
    for _, win_id in ipairs(open_wins) do
        local bufnr = vim.api.nvim_win_get_buf(win_id)
        local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")

        -- convert win_id to string, becuase <amatch>, if exists, will be a string
        local str_win_id = tostring(win_id)

        if str_win_id ~= closed_win and SPECIAL_FILETYPES[filetype] == nil then
            close_flag = false
        end
    end

    -- check flag and close window
    if close_flag then
        vim.cmd("qall")
    end
end

-- function to open ide tests window, properly
-- positioned with outline symbols window
function _ide_open_unittest_window()
    local open_wins = vim.api.nvim_list_wins()
    local original_win_id = vim.api.nvim_get_current_win()

    local outline_exists = false
    local outline_win_id = -1

    for _, win_id in ipairs(open_wins) do
        local bufnr = vim.api.nvim_win_get_buf(win_id)
        local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")
        if filetype == "Outline" then
            outline_exists = true
            outline_win_id = win_id
        end
    end

    if outline_exists then
        vim.api.nvim_set_current_win(outline_win_id)
        vim.cmd("rightbelow split")

        -- doing this trick because last window opened before
        -- tests window must be original window
        local new_win_id = vim.api.nvim_get_current_win()
        vim.api.nvim_set_current_win(original_win_id)
        vim.api.nvim_set_current_win(new_win_id)
    else
        vim.cmd("botright vsplit | vertical resize 30")
    end
end

-- function to open ide symbols window, properly
-- positioned with tests window
function _ide_open_symbols_window()
    local open_wins = vim.api.nvim_list_wins()
    local original_win_id = vim.api.nvim_get_current_win()

    local tests_exists = false
    local tests_win_id = -1

    for _, win_id in ipairs(open_wins) do
        local bufnr = vim.api.nvim_win_get_buf(win_id)
        local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")
        if filetype == "neotest-summary" then
            tests_exists = true
            tests_win_id = win_id
        end
    end

    if tests_exists then
        vim.api.nvim_set_current_win(tests_win_id)
        vim.cmd("leftabove split")

        -- doing this trick because last window opened before
        -- tests window must be original window
        local new_win_id = vim.api.nvim_get_current_win()
        vim.api.nvim_set_current_win(original_win_id)
        vim.api.nvim_set_current_win(new_win_id)
    else
        vim.cmd("botright vsplit")
    end
end

function _ide_protect_windows(args)
    -- buffer types to protect
    local protected_types_list = {}
    for k, _ in pairs(SPECIAL_FILETYPES) do
        table.insert(protected_types_list, k)
    end

    -- utility function
    local function make_set(arr)
        local result = {}
        for _, value in pairs(arr) do
            result[value] = true
        end
        return result
    end

    -- collect information about all opened windows
    local opened_windows = vim.api.nvim_list_wins()
    local protected_types_set = make_set(protected_types_list)

    local is_window_protected = {}
    local window_to_buffer = {}

    for _, win_id in pairs(opened_windows) do
        local status, bufnr = pcall(vim.api.nvim_win_get_buf, win_id)
        if status then
            window_to_buffer[win_id] = bufnr

            local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")
            if protected_types_set[filetype] then
                is_window_protected[win_id] = true
            else
                is_window_protected[win_id] = false
            end
        end
    end

    -- make decision about protecting a window
    local win_id = vim.api.nvim_get_current_win()
    if not is_window_protected[win_id] then
        return
    end

    -- protected window flow: we need to change
    -- current window back to editor, to open file there
    for candidate_id, protected in pairs(is_window_protected) do
        if not protected then
            vim.api.nvim_set_current_win(candidate_id)
            break
        end
    end
end

function _process_term_close()
    local cur_buf = vim.api.nvim_get_current_buf()
    local new_buf = vim.api.nvim_create_buf(true, false)
    local open_wins = vim.api.nvim_list_wins()

    for _, win_id in ipairs(open_wins) do
        local bufnr = vim.api.nvim_win_get_buf(win_id)
        if bufnr == cur_buf then
            vim.api.nvim_win_set_buf(win_id, new_buf)
        end
    end

    vim.api.nvim_buf_delete(cur_buf, {})
end

-- This function with probability 99.99% will open
-- an empty symbols panel, because at that moment LSP
-- client will not be attached. This is why we also
-- need to call function above in lspconfig's `on_attach`.
function initial_setup()
    -- set ide mode flag
    _ide_mode = "partial"

    -- always setup TermClose handler
    -- it prevents closing neovim after closing terminal buffer
    vim.cmd([[ autocmd TermClose * lua _process_term_close() ]])

    -- check ide mode
    if _ide_mode == "none" then
        return
    end

    -- register callback on window/tab/buffer close
    -- this will help correctly close all windows if
    -- code editing is finished (all files are closed)
    vim.cmd([[ autocmd BufDelete * lua _ide_entity_closed({type="buf"}) ]])
    vim.cmd([[ autocmd TabClosed * lua _ide_entity_closed({type="tab"}) ]])
    vim.cmd([[ autocmd WinClosed * lua _ide_entity_closed({type="win"}) ]])

    -- capture all buffer openings, because I want to protect
    -- some windows (like Symbols and Tests) from changing buffers
    -- inside them
    vim.cmd([[ autocmd BufAdd * lua _ide_protect_windows({type="bufadd"}) ]])

    -- call only if window is wide enough
    verify_and_run(
        function()
            vim.cmd("Neotree action=show source=filesystem position=left")
        end
    )
end

-- return module
return {
    on_lsp_attach = on_lsp_attach,
    initial_setup = initial_setup,
}
