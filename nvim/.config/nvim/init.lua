-- global utilities

function dump(o)
    if type(o) == "table" then
        local s = "{ "
        for k,v in pairs(o) do
            if type(k) ~= "number" then k = '"' .. k .. '"' end
            s = s .. "[" .. k .. "] = " .. dump(v) .. ", "
        end
        return s .. "} "
    else
        return tostring(o)
    end
end

function myrequire(path)
    return require("silentz" .. path)
end

-- list of custom modules to load

modules = {
    ".lazy",
    ".options",
    ".keymaps.local",
    ".keymaps.leader",
    ".ide.start",
}

for _, module in ipairs(modules) do
    status, err = pcall(myrequire, module)
    if not status then
        print("Failed to load custom module " .. module .. ": " .. err)
    end
end
