local strings = require('renamer.constants').strings
local renamer = require 'renamer'
local utils = require 'renamer.utils'

local popup = require 'plenary.popup'

local mock = require 'luassert.mock'
local stub = require 'luassert.stub'
local spy = require 'luassert.spy'

local eq = assert.are.same

describe('renamer', function()
    describe('rename', function()
        describe('popup width', function()
            it('should equal to cword length if title is too long', function()
                renamer.setup { title = string.rep('a', 16) }
                local cursor_col, word_start, win_width = 15, 13, 20
                local cword = 'test'
                local expected_width = #cword + 1
                local lsp_mock = mock(vim.lsp, true)
                lsp_mock.buf_get_clients.returns { {} }
                local api_mock = mock(vim.api, true)
                api_mock.nvim_win_get_cursor.returns { 1, cursor_col }
                api_mock.nvim_command.returns()
                api_mock.nvim_buf_line_count.returns(1)
                api_mock.nvim_get_mode.returns {}
                api_mock.nvim_win_get_width.returns(win_width)
                api_mock.nvim_win_get_height.returns(100)
                local expand = stub(vim.fn, 'expand').returns(cword)
                stub(utils, 'get_word_boundaries_in_line').returns(word_start, word_start + expected_width)
                local document_highlight = stub(renamer, '_document_highlight')
                local set_cursor = stub(renamer, '_set_cursor_to_popup_end')
                stub(popup, 'create').returns(1, {})

                local _, opts = renamer.rename()

                eq(expected_width, opts.opts.width)
                mock.revert(api_mock)
                mock.revert(lsp_mock)
                document_highlight.revert(document_highlight)
                expand.revert(expand)
                set_cursor.revert(set_cursor)
            end)

            it('should equal to cword length if otherwise too short', function()
                renamer.setup { title = 'a' }
                local cursor_col, word_start, win_width = 15, 13, 20
                local cword = 'testing'
                local expected_width = #cword + 1
                local lsp_mock = mock(vim.lsp, true)
                lsp_mock.buf_get_clients.returns { {} }
                local api_mock = mock(vim.api, true)
                api_mock.nvim_win_get_cursor.returns { 1, cursor_col }
                api_mock.nvim_command.returns()
                api_mock.nvim_buf_line_count.returns(1)
                api_mock.nvim_get_mode.returns {}
                api_mock.nvim_win_get_width.returns(win_width)
                api_mock.nvim_win_get_height.returns(10)
                local expand = stub(vim.fn, 'expand').returns(cword)
                stub(utils, 'get_word_boundaries_in_line').returns(word_start, word_start + expected_width)
                local document_highlight = stub(renamer, '_document_highlight').returns()
                local set_cursor = stub(renamer, '_set_cursor_to_popup_end')
                stub(popup, 'create').returns(1, {})

                local _, opts = renamer.rename()

                eq(expected_width, opts.opts.width)
                mock.revert(api_mock)
                mock.revert(lsp_mock)
                document_highlight.revert(document_highlight)
                expand.revert(expand)
                set_cursor.revert(set_cursor)
            end)
        end)

        describe('with border', function()
            before_each(function()
                renamer.setup()
            end)

            it('should call `_set_prompt_border_win_style`', function()
                local lsp_mock = mock(vim.lsp, true)
                lsp_mock.buf_get_clients.returns { {} }
                local api_mock = mock(vim.api, true)
                api_mock.nvim_win_get_cursor.returns { 1, 2 }
                api_mock.nvim_command.returns()
                api_mock.nvim_buf_line_count.returns(1)
                api_mock.nvim_get_mode.returns {}
                api_mock.nvim_win_get_width.returns(100)
                api_mock.nvim_win_get_height.returns(10)
                local set_prompt_border_win_style = spy.on(renamer, '_set_prompt_border_win_style')
                stub(utils, 'get_word_boundaries_in_line').returns(1, 2)
                local document_highlight = stub(renamer, '_document_highlight').returns()
                local set_cursor = stub(renamer, '_set_cursor_to_popup_end')
                stub(popup, 'create').returns(1, { border = { win_id = 1 } })

                renamer.rename()

                assert.spy(set_prompt_border_win_style).was_called_with(1)
                mock.revert(api_mock)
                mock.revert(lsp_mock)
                document_highlight.revert(document_highlight)
                set_cursor.revert(set_cursor)
            end)

            it('should use cursor line for line position if there is enough space below', function()
                local cursor_line = 1
                local expected_line_no = 2
                local expected_line = strings.plenary_popup_cursor_plus .. expected_line_no
                local lsp_mock = mock(vim.lsp, true)
                lsp_mock.buf_get_clients.returns { {} }
                local api_mock = mock(vim.api, true)
                api_mock.nvim_win_get_cursor.returns { cursor_line, 2 }
                api_mock.nvim_command.returns()
                api_mock.nvim_buf_line_count.returns(cursor_line + expected_line_no + 1)
                api_mock.nvim_get_mode.returns {}
                api_mock.nvim_win_get_width.returns(100)
                api_mock.nvim_win_get_height.returns(10)
                stub(utils, 'get_word_boundaries_in_line').returns(1, 2)
                local document_highlight = stub(renamer, '_document_highlight').returns()
                local set_cursor = stub(renamer, '_set_cursor_to_popup_end')
                stub(popup, 'create').returns(1, {})

                local _, opts = renamer.rename()

                eq(expected_line, opts.opts.line)
                mock.revert(api_mock)
                mock.revert(lsp_mock)
                document_highlight.revert(document_highlight)
                set_cursor.revert(set_cursor)
            end)

            it('should use flip line position if at the end of the screen', function()
                local expected_line_no = 2
                local expected_line = strings.plenary_popup_cursor_minus .. expected_line_no
                local lsp_mock = mock(vim.lsp, true)
                lsp_mock.buf_get_clients.returns { {} }
                local api_mock = mock(vim.api, true)
                api_mock.nvim_win_get_cursor.returns { 9, 2 }
                api_mock.nvim_command.returns()
                api_mock.nvim_buf_line_count.returns(10)
                api_mock.nvim_get_mode.returns {}
                api_mock.nvim_win_get_width.returns(100)
                api_mock.nvim_win_get_height.returns(10)
                stub(utils, 'get_word_boundaries_in_line').returns(1, 2)
                local document_highlight = stub(renamer, '_document_highlight').returns()
                local set_cursor = stub(renamer, '_set_cursor_to_popup_end')
                stub(popup, 'create').returns(1, {})

                local _, opts = renamer.rename()

                eq(expected_line, opts.opts.line)
                mock.revert(api_mock)
                mock.revert(lsp_mock)
                document_highlight.revert(document_highlight)
                set_cursor.revert(set_cursor)
            end)

            it('should not flip line pos if there is enough space after the last line', function()
                local expected_line_no = 2
                local expected_line = strings.plenary_popup_cursor_plus .. expected_line_no
                local lsp_mock = mock(vim.lsp, true)
                lsp_mock.buf_get_clients.returns { {} }
                local api_mock = mock(vim.api, true)
                api_mock.nvim_win_get_cursor.returns { 5, 2 }
                api_mock.nvim_command.returns()
                api_mock.nvim_buf_line_count.returns(5)
                api_mock.nvim_get_mode.returns {}
                api_mock.nvim_win_get_width.returns(100)
                api_mock.nvim_win_get_height.returns(10)
                stub(utils, 'get_word_boundaries_in_line').returns(1, 2)
                local document_highlight = stub(renamer, '_document_highlight').returns()
                local set_cursor = stub(renamer, '_set_cursor_to_popup_end')
                stub(popup, 'create').returns(1, {})

                local _, opts = renamer.rename()

                eq(expected_line, opts.opts.line)
                mock.revert(api_mock)
                mock.revert(lsp_mock)
                document_highlight.revert(document_highlight)
                set_cursor.revert(set_cursor)
            end)

            it('should set the column position at the begining of the cword (cursor column inside word)', function()
                local expected_col_no = 2
                local expected_col = strings.plenary_popup_cursor_minus .. expected_col_no
                local lsp_mock = mock(vim.lsp, true)
                lsp_mock.buf_get_clients.returns { {} }
                local api_mock = mock(vim.api, true)
                api_mock.nvim_win_get_cursor.returns { 1, expected_col_no + 1 }
                api_mock.nvim_command.returns()
                api_mock.nvim_buf_line_count.returns(1)
                api_mock.nvim_get_mode.returns {}
                api_mock.nvim_win_get_width.returns(100)
                api_mock.nvim_win_get_height.returns(10)
                stub(utils, 'get_word_boundaries_in_line').returns(expected_col_no, 2)
                local set_cursor = stub(renamer, '_set_cursor_to_popup_end')
                local document_highlight = stub(renamer, '_document_highlight').returns()
                stub(popup, 'create').returns(1, {})

                local _, opts = renamer.rename()

                eq(expected_col, opts.opts.col)
                mock.revert(api_mock)
                mock.revert(lsp_mock)
                document_highlight.revert(document_highlight)
                set_cursor.revert(set_cursor)
            end)

            it('should set the column position at the begining of the cword (cursor column at word start)', function()
                local cursor_col = 10
                local expected_col_no = 1
                local expected_col = strings.plenary_popup_cursor_minus .. expected_col_no
                local lsp_mock = mock(vim.lsp, true)
                lsp_mock.buf_get_clients.returns { {} }
                local api_mock = mock(vim.api, true)
                api_mock.nvim_win_get_cursor.returns { 1, cursor_col }
                api_mock.nvim_command.returns()
                api_mock.nvim_buf_line_count.returns(1)
                api_mock.nvim_get_mode.returns {}
                api_mock.nvim_win_get_width.returns(100)
                api_mock.nvim_win_get_height.returns(10)
                stub(utils, 'get_word_boundaries_in_line').returns(cursor_col, 2)
                local set_cursor = stub(renamer, '_set_cursor_to_popup_end')
                local document_highlight = stub(renamer, '_document_highlight').returns()
                stub(popup, 'create').returns(1, {})

                local _, opts = renamer.rename()

                eq(expected_col, opts.opts.col)
                mock.revert(api_mock)
                mock.revert(lsp_mock)
                document_highlight.revert(document_highlight)
                set_cursor.revert(set_cursor)
            end)

            it('should set the column position at the begining of the cword (cursor column at word end)', function()
                local cursor_col = 10
                local word_start = 5
                local expected_col_no = cursor_col - word_start + 1
                local expected_col = strings.plenary_popup_cursor_minus .. expected_col_no
                local lsp_mock = mock(vim.lsp, true)
                lsp_mock.buf_get_clients.returns { {} }
                local api_mock = mock(vim.api, true)
                api_mock.nvim_win_get_cursor.returns { 1, cursor_col }
                api_mock.nvim_command.returns()
                api_mock.nvim_buf_line_count.returns(1)
                api_mock.nvim_get_mode.returns {}
                api_mock.nvim_win_get_width.returns(100)
                api_mock.nvim_win_get_height.returns(10)
                stub(utils, 'get_word_boundaries_in_line').returns(word_start, 2)
                local set_cursor = stub(renamer, '_set_cursor_to_popup_end')
                local document_highlight = stub(renamer, '_document_highlight').returns()
                stub(popup, 'create').returns(1, {})

                local _, opts = renamer.rename()

                eq(expected_col, opts.opts.col)
                mock.revert(api_mock)
                mock.revert(lsp_mock)
                document_highlight.revert(document_highlight)
                set_cursor.revert(set_cursor)
            end)

            it('should set the column position to have enough space to draw popup (cword at window end)', function()
                local cursor_col = 19
                local word_start = 17
                local win_width = 20
                -- no `word_start` as the formula would have `... - word_start ... + word_start`
                local expected_col_no = cursor_col + 1 + #renamer.title + 4 - win_width + 4
                local expected_col = strings.plenary_popup_cursor_minus .. expected_col_no
                local lsp_mock = mock(vim.lsp, true)
                lsp_mock.buf_get_clients.returns { {} }
                local api_mock = mock(vim.api, true)
                api_mock.nvim_win_get_cursor.returns { 1, cursor_col }
                api_mock.nvim_command.returns()
                api_mock.nvim_buf_line_count.returns(1)
                api_mock.nvim_get_mode.returns {}
                api_mock.nvim_win_get_width.returns(win_width)
                api_mock.nvim_win_get_height.returns(10)
                stub(utils, 'get_word_boundaries_in_line').returns(word_start, word_start + 5)
                local set_cursor = stub(renamer, '_set_cursor_to_popup_end')
                local document_highlight = stub(renamer, '_document_highlight').returns()
                stub(popup, 'create').returns(1, {})

                local _, opts = renamer.rename()

                eq(expected_col, opts.opts.col)
                mock.revert(api_mock)
                mock.revert(lsp_mock)
                document_highlight.revert(document_highlight)
                set_cursor.revert(set_cursor)
            end)
        end)

        describe('without border', function()
            before_each(function()
                renamer.setup { border = false }
            end)

            it('should use cursor line for line position if there is enough space below', function()
                local cursor_line = 1
                local expected_line_no = 1
                local expected_line = strings.plenary_popup_cursor_plus .. expected_line_no
                local lsp_mock = mock(vim.lsp, true)
                lsp_mock.buf_get_clients.returns { {} }
                local api_mock = mock(vim.api, true)
                api_mock.nvim_win_get_cursor.returns { cursor_line, 2 }
                api_mock.nvim_command.returns()
                api_mock.nvim_buf_line_count.returns(cursor_line + expected_line_no + 1)
                api_mock.nvim_get_mode.returns {}
                api_mock.nvim_win_get_width.returns(100)
                api_mock.nvim_win_get_height.returns(10)
                stub(utils, 'get_word_boundaries_in_line').returns(1, 2)
                local set_cursor = stub(renamer, '_set_cursor_to_popup_end')
                local document_highlight = stub(renamer, '_document_highlight').returns()
                stub(popup, 'create').returns(1, {})

                local _, opts = renamer.rename()

                eq(expected_line, opts.opts.line)
                mock.revert(api_mock)
                mock.revert(lsp_mock)
                document_highlight.revert(document_highlight)
                set_cursor.revert(set_cursor)
            end)

            it('should use flip line position if at the end of the screen', function()
                local expected_line_no = 1
                local expected_line = strings.plenary_popup_cursor_minus .. expected_line_no
                local lsp_mock = mock(vim.lsp, true)
                lsp_mock.buf_get_clients.returns { {} }
                local api_mock = mock(vim.api, true)
                api_mock.nvim_win_get_cursor.returns { 10, 2 }
                api_mock.nvim_command.returns()
                api_mock.nvim_buf_line_count.returns(10)
                api_mock.nvim_get_mode.returns {}
                api_mock.nvim_win_get_width.returns(100)
                api_mock.nvim_win_get_height.returns(10)
                stub(utils, 'get_word_boundaries_in_line').returns(1, 2)
                local set_cursor = stub(renamer, '_set_cursor_to_popup_end')
                local document_highlight = stub(renamer, '_document_highlight').returns()
                stub(popup, 'create').returns(1, {})

                local _, opts = renamer.rename()

                eq(expected_line, opts.opts.line)
                mock.revert(api_mock)
                mock.revert(lsp_mock)
                document_highlight.revert(document_highlight)
                set_cursor.revert(set_cursor)
            end)

            it('should not flip line pos if there is enough space after the last line', function()
                local expected_line_no = 1
                local expected_line = strings.plenary_popup_cursor_plus .. expected_line_no
                local lsp_mock = mock(vim.lsp, true)
                lsp_mock.buf_get_clients.returns { {} }
                local api_mock = mock(vim.api, true)
                api_mock.nvim_win_get_cursor.returns { 5, 2 }
                api_mock.nvim_command.returns()
                api_mock.nvim_buf_line_count.returns(5)
                api_mock.nvim_get_mode.returns {}
                api_mock.nvim_win_get_width.returns(100)
                api_mock.nvim_win_get_height.returns(10)
                stub(utils, 'get_word_boundaries_in_line').returns(1, 2)
                local set_cursor = stub(renamer, '_set_cursor_to_popup_end')
                local document_highlight = stub(renamer, '_document_highlight').returns()
                stub(popup, 'create').returns(1, {})

                local _, opts = renamer.rename()

                eq(expected_line, opts.opts.line)
                mock.revert(api_mock)
                mock.revert(lsp_mock)
                document_highlight.revert(document_highlight)
                set_cursor.revert(set_cursor)
            end)

            it('should set the column position at the begining of the cword (cursor column inside word)', function()
                local expected_col_no = 1
                local expected_col = strings.plenary_popup_cursor_minus .. expected_col_no
                local lsp_mock = mock(vim.lsp, true)
                lsp_mock.buf_get_clients.returns { {} }
                local api_mock = mock(vim.api, true)
                api_mock.nvim_win_get_cursor.returns { 1, expected_col_no + 1 }
                api_mock.nvim_command.returns()
                api_mock.nvim_buf_line_count.returns(1)
                api_mock.nvim_get_mode.returns {}
                api_mock.nvim_win_get_width.returns(100)
                api_mock.nvim_win_get_height.returns(10)
                stub(utils, 'get_word_boundaries_in_line').returns(expected_col_no + 1, 2)
                local set_cursor = stub(renamer, '_set_cursor_to_popup_end')
                local document_highlight = stub(renamer, '_document_highlight').returns()
                stub(popup, 'create').returns(1, {})

                local _, opts = renamer.rename()

                eq(expected_col, opts.opts.col)
                mock.revert(api_mock)
                mock.revert(lsp_mock)
                document_highlight.revert(document_highlight)
                set_cursor.revert(set_cursor)
            end)

            it('should set the column position at the begining of the cword (cursor column at word start)', function()
                local cursor_col = 10
                local expected_col_no = 0
                local expected_col = strings.plenary_popup_cursor_minus .. expected_col_no
                local lsp_mock = mock(vim.lsp, true)
                lsp_mock.buf_get_clients.returns { {} }
                local api_mock = mock(vim.api, true)
                api_mock.nvim_win_get_cursor.returns { 1, cursor_col }
                api_mock.nvim_command.returns()
                api_mock.nvim_buf_line_count.returns(1)
                api_mock.nvim_get_mode.returns {}
                api_mock.nvim_win_get_width.returns(100)
                api_mock.nvim_win_get_height.returns(10)
                stub(utils, 'get_word_boundaries_in_line').returns(cursor_col + 1, 2)
                local set_cursor = stub(renamer, '_set_cursor_to_popup_end')
                local document_highlight = stub(renamer, '_document_highlight').returns()
                stub(popup, 'create').returns(1, {})

                local _, opts = renamer.rename()

                eq(expected_col, opts.opts.col)
                mock.revert(api_mock)
                mock.revert(lsp_mock)
                document_highlight.revert(document_highlight)
                set_cursor.revert(set_cursor)
            end)

            it('should set the column position at the begining of the cword (cursor column at word end)', function()
                local cursor_col = 10
                local word_start = 5
                local expected_col_no = cursor_col - word_start + 1
                local expected_col = strings.plenary_popup_cursor_minus .. expected_col_no
                local lsp_mock = mock(vim.lsp, true)
                lsp_mock.buf_get_clients.returns { {} }
                local api_mock = mock(vim.api, true)
                api_mock.nvim_win_get_cursor.returns { 1, cursor_col }
                api_mock.nvim_command.returns()
                api_mock.nvim_buf_line_count.returns(1)
                api_mock.nvim_get_mode.returns {}
                api_mock.nvim_win_get_width.returns(100)
                api_mock.nvim_win_get_height.returns(10)
                stub(utils, 'get_word_boundaries_in_line').returns(word_start, 2)
                local set_cursor = stub(renamer, '_set_cursor_to_popup_end')
                local document_highlight = stub(renamer, '_document_highlight').returns()
                stub(popup, 'create').returns(1, {})

                local _, opts = renamer.rename()

                eq(expected_col, opts.opts.col)
                mock.revert(api_mock)
                mock.revert(lsp_mock)
                document_highlight.revert(document_highlight)
                set_cursor.revert(set_cursor)
            end)

            it('should set the column position to have enough space to draw popup (cword at window end)', function()
                local cursor_col = 19
                local word_start = 17
                local win_width = 20
                -- no `word_start` as the formula would have `... - word_start ... + word_start`
                local expected_col_no = cursor_col + 1 + #renamer.title + 4 - win_width
                local expected_col = strings.plenary_popup_cursor_minus .. expected_col_no
                local lsp_mock = mock(vim.lsp, true)
                lsp_mock.buf_get_clients.returns { {} }
                local api_mock = mock(vim.api, true)
                api_mock.nvim_win_get_cursor.returns { 1, cursor_col }
                api_mock.nvim_command.returns()
                api_mock.nvim_buf_line_count.returns(1)
                api_mock.nvim_get_mode.returns {}
                api_mock.nvim_win_get_width.returns(win_width)
                api_mock.nvim_win_get_height.returns(10)
                stub(utils, 'get_word_boundaries_in_line').returns(word_start, word_start + 5)
                local set_cursor = stub(renamer, '_set_cursor_to_popup_end')
                local document_highlight = stub(renamer, '_document_highlight').returns()
                stub(popup, 'create').returns(1, {})

                local _, opts = renamer.rename()

                eq(expected_col, opts.opts.col)
                mock.revert(api_mock)
                mock.revert(lsp_mock)
                document_highlight.revert(document_highlight)
                set_cursor.revert(set_cursor)
            end)
        end)
    end)
end)
