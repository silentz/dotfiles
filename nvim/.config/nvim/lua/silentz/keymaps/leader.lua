local status_ok, whichkey = pcall(require, "which-key")
if not status_ok then
    print("ERROR", whichkey)
    return
end

local opts = {
    prefix = "<leader>",
    mode = "n",     -- NORMAL mode
    buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true,  -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true,  -- use `nowait` when creating keymaps
}

local mappings = {
    h = { "<cmd>nohlsearch<CR>", "Clear higlight" },
    s = { "<cmd>Telescope live_grep<cr>", "Search" },
    f = { "<cmd>Telescope find_files<cr>", "Find Files" },
    S = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Search Current Buffer" },
    e = { "<cmd>TodoTelescope<cr>", "All TODO-comments"},

    b = {
        name = "Buffers",
        b = {
            "<cmd>Telescope buffers initial_mode=normal<cr>",
            "Buffer List",
        },
        d = { "<cmd>lua require('mini.bufremove').delete(0, false)<cr>", "Buffer Delete" },
        n = { "<cmd>tabnew<cr>", "New tab" },
        r = { "<cmd>edit<cr>", "Buffer Reload" },
    },

    t = {
        name = "Tests",

        -- run tests
        a = {
            "<cmd>lua require('neotest').run.run({suite=true})<cr>",
            "All",
        },
        t = {
            "<cmd>lua require('neotest').run.run()<cr>",
            "Nearest",
        },
        f = {
            "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>",
            "File",
        },
        m = {
            "<cmd>lua require('neotest').silentz.run_flat_module(vim.fn.expand('%:p:h'))<cr>",
            "Module/Dir (flat)",
        },
        M = {
            "<cmd>lua require('neotest').run.run(vim.fn.expand('%:p:h'))<cr>",
            "Module/Dir (recursive)",
        },
        l = {
            "<cmd>lua require('neotest').run.run_last()<cr>",
            "Last",
        },

        -- outputs
        o = {
            "<cmd>lua require('neotest').output.open({ enter = true })<cr>",
            "Output",
        },
        s = {
            "<cmd>lua require('neotest').summary.toggle()<cr>",
            "Summary",
        },

        -- while running
        A = {
            "<cmd>lua require('neotest').run.attach()<cr>",
            "Attach",
        },
        S = {
            "<cmd>lua require('neotest').run.stop()<cr>",
            "Stop",
        },
    },

    g = {
        name = "Git",
        g = { "<cmd>lua _GIT_WINDOW_TOGGLE()<cr>", "UI Client" },

        S = { "<cmd>Telescope git_status<cr>", "Git Status [T]" },
        b = { "<cmd>Telescope git_branches<cr>", "Checkout branch [T]" },
        c = { "<cmd>Telescope git_commits<cr>", "Checkout commit [T]" },

        ["["] = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
		["]"] = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },

		l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
        s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
		u = { "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", "Undo Stage Hunk", },

		p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
		r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
		R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
    },

    l = {
        name = "LSP",

        -- lsp plugin ops
        i = { "<cmd>LspInfo<cr>", "Info" },
        R = {
            "<cmd>LspRestart<cr>",
            "Restart",
        },

        -- change code
        f = { "<cmd>lua vim.lsp.buf.format()<cr>", "Format" },
        r = { "<cmd>lua require('renamer').rename()<cr>", "Rename" },

        -- diagnistics
        d = {
            "<cmd>Telescope diagnostics<cr>",
            "Document Diagnostics",
        },
        ["]"] = {
            "<cmd>lua vim.lsp.diagnostic.goto_next()<cr>",
            "Next Diagnostic",
        },
        ["["] = {
            "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>",
            "Prev Diagnostic",
        },

        -- symbols info
        s = {
            "<cmd>Telescope lsp_document_symbols<cr>",
            "Document Symbols",
        },
        S = {
            "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
            "Workspace Symbols",
        },

        -- docstrings
        g = {
            name = "Docstrings",
            g = {
                "<cmd>lua require('neogen').generate()<cr>",
                "Generate docstring (common)",
            },
            t = {
                "<cmd>lua require('neogen').generate({type='type'})<cr>",
                "Generate docstring for type",
            },
            f = {
                "<cmd>lua require('neogen').generate({type='func'})<cr>",
                "Generate docstring for function",
            },
            c = {
                "<cmd>lua require('neogen').generate({type='class'})<cr>",
                "Generate docstring for class",
            },
        },
    },
}

whichkey.register(mappings, opts)
