local strings = require('renamer.constants').strings
local utils = require 'renamer.mappings.utils'

--- @class Mappings
--- @field public default_bindings table
--- @field public keymap_opts table
local mappings = {
    default_bindings = {
        ['<c-i>'] = utils.set_cursor_to_start,
        ['<c-a>'] = utils.set_cursor_to_end,
        ['<c-e>'] = utils.set_cursor_to_word_end,
        ['<c-b>'] = utils.set_cursor_to_word_start,
        ['<c-c>'] = utils.clear_line,
        ['<c-u>'] = utils.undo,
        ['<c-r>'] = utils.redo,
    },
    bindings = {},
    keymap_opts = {
        noremap = true,
        silent = true,
    },
}

mappings.register_bindings = function(buf_id)
    if buf_id and mappings.bindings then
        for binding, _ in pairs(mappings.bindings) do
            local action = string.format(strings.exec_keymap_action_command_template, binding:gsub('<', '<lt>'))
            vim.api.nvim_buf_set_keymap(buf_id, strings.insert_mode_short_string, binding, action, mappings.keymap_opts)
        end
    end
end

mappings.exec_keymap_action = function(binding)
    if binding and mappings.bindings and mappings.bindings[binding] then
        mappings.bindings[binding]()
    end
end

return mappings
