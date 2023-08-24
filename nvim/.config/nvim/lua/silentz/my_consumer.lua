-- global field is initiated when neotest loads consumer
-- see: https://github.com/nvim-neotest/neotest/blob/master/doc/neotest.txt
-- (neotest.consumer section of documentation)
local client

-- definition of my consumer
Consumer = {}

-- helper function to differ between dict-like
-- tables and array-like tables
local function is_array(t)
    local idx = 1
    for _ in pairs(t) do
        if t[idx] == nil then
            return false
        else
            idx = idx + 1
        end
    end
    return true
end

-- remove recursion from tree and keep only
-- first level module (without subdirs)
local function remove_submodules(tree_list)
    local result_list = {}

    for _, item in pairs(tree_list) do
        if is_array(item) then
            -- item is array. array can be anything: file, dir, namespace, test
            -- we need to filter out all `dir` items, because they contain submodules
            local array_size = #item

            -- if array is empty, there is no reason to keep it
            if array_size > 0 then
                -- filter out item, if head element of subtree is dir
                local first_item = item[1]
                if first_item.type ~= "dir" then
                    table.insert(result_list, item)
                end
            end
        else
            -- save if item is not array -> top level
            table.insert(result_list, item)
        end
    end

    return result_list
end

-- this function gets neotree args as an arguemnt,
-- gets neotest-tree from it and removes
-- recursive modules (keeps only first level)
-- and then runs it
function Consumer.run_flat_module(args)
    local neotest_run = require("neotest.consumers.run")
    local neotest_types = require("neotest.types")

    local before_tree = neotest_run.get_tree_from_args(args, true)
    local before_list = before_tree:to_list()

    local after_list = remove_submodules(before_list)
    local after_tree = neotest_types.Tree.from_list(
        after_list,
        function(pos) -- get the key of each node
            return pos.id
        end
    )

    client:run_tree(
        after_tree,
        type(args) == "string" and { args } or args
    )
end

Consumer = setmetatable(Consumer, {
    __call = function(_, client_)
        client = client_
        return Consumer
    end,
})

return Consumer
