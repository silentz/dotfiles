local status_ok, ayu = pcall(require, "ayu")
if not status_ok then
    print("ERROR", ayu)
    return
end

ayu.setup({
    mirage = false,
    overrides = {},
})

vim.cmd('colorscheme ayu')
