
local colorschemes = {
    ayu = {
        name = "ayu",
        options = {
            mirage = false,
            overrides = {},
        },
    },
    ayu_mirage = {
        name = "ayu",
        options = {
            mirage = true,
            overrides = {},
        },
    },
    github_dark = {
        name = "github-theme",
        options = {
            theme_style = "dark",
        },
    },
    github_dark_colorblind = {
        name = "github-theme",
        options = {
            theme_style = "dark_colorblind",
        },
    },
    github_dark_default = {
        name = "github-theme",
        options = {
            theme_style = "dark_default",
        },
    },
    github_dimmed = {
        name = "github-theme",
        options = {
            theme_style = "dimmed",
        },
    },
    github_light = {
        name = "github-theme",
        options = {
            theme_style = "light",
        },
    },
    github_light_colorblind = {
        name = "github-theme",
        options = {
            theme_style = "light_colorblind",
        },
    },
    github_light_default = {
        name = "github-theme",
        options = {
            theme_style = "light_default",
        },
    },
}


local function install_colorscheme (config)
    status_ok, scheme = pcall(require, config['name'])
    if not status_ok then
        print("cannot load package " .. package)
        return
    end
    scheme.setup(config['options'])
    scheme.colorscheme()
end


local colorscheme = "ayu_mirage"
install_colorscheme(colorschemes[colorscheme])
