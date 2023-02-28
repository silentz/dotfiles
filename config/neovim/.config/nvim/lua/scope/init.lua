local core = require "scope.core"
local utils = require "scope.utils"
local api = vim.api

local M = {}

function M._setup_legacy()
    vim.cmd [[
    augroup ScopeAU
        autocmd!
        autocmd TabEnter * lua require("scope.core").on_tab_enter()
        autocmd TabLeave * lua require("scope.core").on_tab_leave()
        autocmd TabClosed * lua require("scope.core").on_tab_closed()
        autocmd TabNewEntered * lua require("scope.core").on_tab_new_entered()
    augroup END
    ]]
end

function M._setup()
    local group = api.nvim_create_augroup("ScopeAU", {})
    api.nvim_create_autocmd("TabEnter", { group = group, callback = core.on_tab_enter })
    api.nvim_create_autocmd("TabLeave", { group = group, callback = core.on_tab_leave })
    api.nvim_create_autocmd("TabClosed", { group = group, callback = core.on_tab_closed })
    api.nvim_create_autocmd("TabNewEntered", { group = group, callback = core.on_tab_new_entered })
    api.nvim_create_user_command("ScopeList", core.print_summary, {}) --TODO: improve this
end

function M.setup()
    if utils.is_minimum_version(0, 7, 0) then
        M._setup()
    else
        M._setup_legacy()
    end
end

return M
