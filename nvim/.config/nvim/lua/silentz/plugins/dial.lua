return function()
    local status_ok, dial_config = pcall(require, "dial.config")
    if not status_ok then
        print("ERROR", dial_config)
        return
    end

    local status_ok, dial_augend = pcall(require, "dial.augend")
    if not status_ok then
        print("ERROR", dial_augend)
        return
    end

    local status_ok, dial_map = pcall(require, "dial.map")
    if not status_ok then
        print("ERROR", dial_map)
        return
    end

    dial_config.augends:register_group({
        default = {
            dial_augend.integer.alias.decimal_int,
            dial_augend.integer.alias.hex,
            dial_augend.semver.alias.semver,
            dial_augend.date.alias["%Y/%m/%d"],
            dial_augend.date.alias["%Y-%m-%d"],
            dial_augend.hexcolor.new({}),
            dial_augend.constant.new({
                elements = { "false", "true" },
                word = true,
                cyclic = true,
                preserve_case = true,
            }),
            dial_augend.constant.new({
                elements = { "yes", "no" },
                word = true,
                cyclic = true,
                preserve_case = true,
            }),
        },
    })

    local status_ok, map_keymaps = pcall(myrequire, ".keymaps.dial")
    if not status_ok then
        print("ERROR", map_keymaps)
        return
    end

    map_keymaps(dial_map)
end
