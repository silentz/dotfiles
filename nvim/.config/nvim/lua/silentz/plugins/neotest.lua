return function()
    local status_ok, neotest = pcall(require, "neotest")
    if not status_ok then
        print("ERROR", neotest)
        return
    end

    neotest.setup({
        status = {
            virtual_text = true,
        },
        output = {
            open_on_run  = true,
            auto_close = true,
        },
        adapters = {
            require("neotest-go"),
            require("neotest-python"),
            require("neotest-plenary"),
            require("neotest-dart"), -- untrusted plugin

            -- fallback
            require("neotest-vim-test")({
                -- types processed by other adapters
                ignore_filetypes = { "python", "go", "lua", "dart" },
            }),
        },
        consumers = {
            silentz = myrequire(".my_consumer"),
        },
        summary = {
            -- function from ide.lua to configure window position
            open = "lua _ide_open_unittest_window()",
        },
    })
end
