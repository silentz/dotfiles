return function()
    local status_ok, lualine = pcall(require, "lualine")
    if not status_ok then
        print("ERROR", lualine)
        return
    end

    local filetype = {
        "filetype",
        icons_enabled = false,
        icon = nil,
    }

    local branch = {
        "branch",
        icons_enabled = true,
        icon = "git",
    }

    local location = {
        "location",
        padding = 0,
    }

    local spaces = function()
        return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
    end

    lualine.setup({
        options = {
            icons_enabled = true,
            theme = "auto",
            component_separators = { left = "", right = "" },
            section_separators = { left = "", right = "" },
            disabled_filetypes = { "alpha", "dashboard", "NvimTree" },
            always_divide_middle = true,
        },
        sections = {
            lualine_a = { branch },
            lualine_b = {},
            lualine_c = { "filename" },
            lualine_x = { spaces, "encoding", filetype },
            lualine_y = { location },
            lualine_z = {},
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = { "filename" },
            lualine_x = { "location" },
            lualine_y = {},
            lualine_z = {},
        },
        tabline = {},
        extensions = {},
    })
end
