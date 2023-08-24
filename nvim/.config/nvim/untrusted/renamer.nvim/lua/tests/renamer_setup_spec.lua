local renamer = require 'renamer'

local eq = assert.are.same

describe('renamer', function()
    describe('setup', function()
        local defaults = require 'renamer.defaults'

        it('should use defaults if no options are passed', function()
            local mappings = require 'renamer.mappings'
            renamer.setup()

            eq(defaults.title, renamer.title)
            eq(defaults.padding, renamer.padding)
            eq(defaults.border, renamer.border)
            eq(defaults.border_chars, renamer.border_chars)
            eq(defaults.show_refs, renamer.show_refs)
            eq(defaults.with_qf_list, renamer.with_qf_list)
            eq(defaults.mappings, mappings.bindings)
            eq(defaults.handler, renamer.handler)
            eq({}, renamer._buffers)
        end)

        it('should use defaults where no options are passed ("title" passed)', function()
            local mappings = require 'renamer.mappings'
            local opts = {
                title = 'abc',
            }

            renamer.setup(opts)

            eq(opts.title, renamer.title)
            eq(defaults.padding, renamer.padding)
            eq(defaults.border, renamer.border)
            eq(defaults.border_chars, renamer.border_chars)
            eq(defaults.show_refs, renamer.show_refs)
            eq(defaults.with_qf_list, renamer.with_qf_list)
            eq(defaults.mappings, mappings.bindings)
            eq(defaults.handler, renamer.handler)
            eq({}, renamer._buffers)
        end)

        it('should use defaults where no options are passed ("padding" passed)', function()
            local mappings = require 'renamer.mappings'
            local opts = {
                padding = {
                    top = 1,
                    left = 2,
                    bottom = 3,
                    right = 4,
                },
            }

            renamer.setup(opts)

            eq(defaults.title, renamer.title)
            eq(opts.padding, renamer.padding)
            eq(defaults.border, renamer.border)
            eq(defaults.border_chars, renamer.border_chars)
            eq(defaults.show_refs, renamer.show_refs)
            eq(defaults.with_qf_list, renamer.with_qf_list)
            eq(defaults.mappings, mappings.bindings)
            eq(defaults.handler, renamer.handler)
            eq({}, renamer._buffers)
        end)

        it('should use defaults where no options are passed ("border" passed)', function()
            local mappings = require 'renamer.mappings'
            local opts = {
                border = true,
            }

            renamer.setup(opts)

            eq(defaults.title, renamer.title)
            eq(defaults.padding, renamer.padding)
            eq(opts.border, renamer.border)
            eq(defaults.border_chars, renamer.border_chars)
            eq(defaults.show_refs, renamer.show_refs)
            eq(defaults.with_qf_list, renamer.with_qf_list)
            eq(defaults.mappings, mappings.bindings)
            eq(defaults.handler, renamer.handler)
            eq({}, renamer._buffers)
        end)

        it('should use defaults where no options are passed ("border_chars" passed)', function()
            local mappings = require 'renamer.mappings'
            local opts = {
                border_chars = { '═', '║', '═', '║', '╔', '╗', '╝', '╚' },
            }

            renamer.setup(opts)

            eq(defaults.title, renamer.title)
            eq(defaults.padding, renamer.padding)
            eq(defaults.border, renamer.border)
            eq(opts.border_chars, renamer.border_chars)
            eq(defaults.show_refs, renamer.show_refs)
            eq(defaults.with_qf_list, renamer.with_qf_list)
            eq(defaults.mappings, mappings.bindings)
            eq(defaults.handler, renamer.handler)
            eq({}, renamer._buffers)
        end)

        it('should use defaults where no options are passed ("show_refs" passed)', function()
            local mappings = require 'renamer.mappings'
            local opts = {
                show_refs = false,
            }

            renamer.setup(opts)

            eq(defaults.title, renamer.title)
            eq(defaults.padding, renamer.padding)
            eq(defaults.border, renamer.border)
            eq(defaults.border_chars, renamer.border_chars)
            eq(opts.show_refs, renamer.show_refs)
            eq(defaults.with_qf_list, renamer.with_qf_list)
            eq(defaults.mappings, mappings.bindings)
            eq(defaults.handler, renamer.handler)
            eq({}, renamer._buffers)
        end)

        it('should use defaults where no options are passed ("with_qf_list" passed)', function()
            local mappings = require 'renamer.mappings'
            local opts = {
                with_qf_list = false,
            }

            renamer.setup(opts)

            eq(defaults.title, renamer.title)
            eq(defaults.padding, renamer.padding)
            eq(defaults.border, renamer.border)
            eq(defaults.border_chars, renamer.border_chars)
            eq(defaults.show_refs, renamer.show_refs)
            eq(opts.with_qf_list, renamer.with_qf_list)
            eq(defaults.mappings, mappings.bindings)
            eq(defaults.handler, renamer.handler)
            eq({}, renamer._buffers)
        end)

        it('should use defaults where no options are passed ("mappings" passed)', function()
            local mappings = require 'renamer.mappings'
            local opts = {
                mappings = {
                    ['<c-a>'] = 'test',
                },
            }

            renamer.setup(opts)

            eq(defaults.title, renamer.title)
            eq(defaults.padding, renamer.padding)
            eq(defaults.border, renamer.border)
            eq(defaults.border_chars, renamer.border_chars)
            eq(defaults.show_refs, renamer.show_refs)
            eq(defaults.with_qf_list, renamer.with_qf_list)
            eq(opts.mappings, mappings.bindings)
            eq(defaults.handler, renamer.handler)
            eq({}, renamer._buffers)
        end)

        it('should use defaults where no options are passed ("handler" passed)', function()
            local mappings = require 'renamer.mappings'
            local opts = {
                handler = function(resp)
                    print(resp)
                end,
            }

            renamer.setup(opts)

            eq(defaults.title, renamer.title)
            eq(defaults.padding, renamer.padding)
            eq(defaults.border, renamer.border)
            eq(defaults.border_chars, renamer.border_chars)
            eq(defaults.show_refs, renamer.show_refs)
            eq(defaults.with_qf_list, renamer.with_qf_list)
            eq(defaults.mappings, mappings.bindings)
            eq(opts.handler, renamer.handler)
            eq({}, renamer._buffers)
        end)

        it('should use options if passed', function()
            local mappings = require 'renamer.mappings'
            local opts = {
                title = 'abc',
                padding = {
                    top = 1,
                    left = 2,
                    bottom = 3,
                    right = 4,
                },
                border = false,
                border_chars = { '═', '║', '═', '║', '╔', '╗', '╝', '╚' },
                show_refs = false,
                with_qf_list = false,
                with_popup = false,
                mappings = {
                    ['<c-a>'] = 'test',
                },
                handler = function(resp)
                    print(resp)
                end,
            }

            renamer.setup(opts)

            eq(opts.title, renamer.title)
            eq(opts.padding, renamer.padding)
            eq(opts.border, renamer.border)
            eq(opts.border_chars, renamer.border_chars)
            eq(opts.show_refs, renamer.show_refs)
            eq(opts.with_qf_list, renamer.with_qf_list)
            eq(opts.with_popup, renamer.with_popup)
            eq(opts.mappings, mappings.bindings)
            eq(opts.handler, renamer.handler)
            eq({}, renamer._buffers)
        end)
    end)
end)
