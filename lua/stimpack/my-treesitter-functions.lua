local my_treesitter_functions = {}

vim.keymap.set('n', '<leader><leader>ab', function()
    package.loaded['stimpack.my-treesitter-functions'] = nil
    require('stimpack.my-treesitter-functions')
end, { desc = 'Reload my-treesitter-functions' })

-- Keep a hotkey mapping for my current function under test here
local functionName = 'current_location_is_in_lua_table'
vim.keymap.set('n', '<leader><leader>ui', function()
    my_treesitter_functions.lua[functionName]()
end, { desc = string.format('Run TS function: %s', functionName) })

local get_root = function(bufnr, language)
    local parser = vim.treesitter.get_parser(bufnr, language, {})
    local tree = parser:parse()[1]
    return tree:root()
end

my_treesitter_functions.all = {
    get_all_buffers = function(pattern)
        local buffer_list = {}

        for _, open_buffers in pairs(vim.fn.getbufinfo({ buflisted = true })) do
            local buffer_number
            if type(pattern) == 'string' and open_buffers.name:match(pattern) then
                if next(open_buffers) then
                    buffer_number = open_buffers.bufnr
                end
            end
            table.insert(buffer_list, buffer_number)
        end
        return buffer_list
    end,
}

local function get_test_function_names(query, language, buffer_filter, capture_id_filter)
    local test_function_locations = {}
    for _, bufnr in pairs(my_treesitter_functions.all.get_all_buffers(buffer_filter)) do
        local root = get_root(bufnr, language)

        for id, node in query:iter_captures(root, bufnr, 0, -1) do
            local name = vim.treesitter.get_node_text(node, bufnr):gsub('"', ''):gsub('\'', '')
            if test_function_locations.name == nil then
                test_function_locations[name] = {
                    range = { node:range() },
                    node_capture_group = query.captures[id],
                    name = name,
                    bufnr = bufnr,
                }

                if capture_id_filter ~= nil and string.match(query.captures[id], capture_id_filter) == nil then
                    test_function_locations[name] = nil
                end
            end
        end
    end
    return test_function_locations
end

local function get_recent_var_from_node(query, language)
    local bufnr = vim.api.nvim_get_current_buf()
    local root = get_root(bufnr, language)

    local current_row = vim.api.nvim_win_get_cursor(0)
    local variable_name = ''
    for _, node in query:iter_captures(root, bufnr, 0, -1) do
        -- print(vim.treesitter.get_node_text(node, bufnr))
        local _, _, row, _ = node:range()
        if row < current_row[1] then
            variable_name = vim.treesitter.get_node_text(node, bufnr)
        end
    end

    return variable_name
end

--- Return table of nodes until parent node is found
---@param node TSNode
---@return TSNode | nil
my_treesitter_functions.find_chain_to_parent_node = function(node)
    local nodes = {}

    local root_parent_found = false
    while root_parent_found == false and node ~= nil do
        if node.parent ~= nil then
            local next_parent = node:parent()
            if next_parent then
                node = next_parent
                -- V(node:type())
                table.insert(nodes, node)
            else
                root_parent_found = true
                -- V('Root node of parent found')
            end
        end
    end

    return nodes
end

--- Find parent node not to be confused with the total root node
---@param node TSNode
---@return TSNode | nil
my_treesitter_functions.find_parent_node = function(node)
    local root_parent_found = false
    while root_parent_found == false and node ~= nil do
        if node.parent ~= nil then
            local next_parent = node:parent()
            if next_parent then
                node = next_parent
                -- V(node:type())
            else
                root_parent_found = true
                -- V('Root node of parent found')
            end
        end
    end

    return node
end

--- Check if node contains child of certain type
---@param node TSNode
---@param type string
---@return boolean
my_treesitter_functions.does_node_contain_child = function(node, type)
    local match = false
    if node ~= nil and type ~= nil then
        for child, field in node:iter_children() do
            V(child, field)
            if field == child:type() then
                match = true
            end
        end
    end

    return match
end

my_treesitter_functions.lua = {
    get_recent_var = function()
        local language = 'lua'
        local query_recent_var_lua = vim.treesitter.query.parse(language, '(variable_list) @lua_variable')
        return get_recent_var_from_node(query_recent_var_lua, language)
    end,
    get_test_function_names = function()
        local language = 'lua'

        -- First attempt, this gets matches the function call of the "it" function call
        -- '((function_call name: (identifier) @test_function_name (#eq? @test_function_name "it")))'

        -- Better version to get the test name (location comes with it as well)
        -- ((function_call name: (identifier) @test_function_name (#eq? @test_function_name "it") arguments: (arguments (string)@test_name)))
        local get_test_function_names_query = vim.treesitter.query.parse(
            language,
            '((function_call name: (identifier) @test_function_name (#eq? @test_function_name "it") arguments: (arguments (string)@test_name)))'
        )

        -- V(get_test_function_names_query)
        local output = get_test_function_names(get_test_function_names_query, language, '.*_spec%.lua', 'test_name')
        -- local final_output = {}
        --
        -- for _, value in pairs(output) do
        --     if value.node_capture_group == 'test_name' then
        --         table.insert(final_output, value)
        --     end
        -- end
        -- return final_output
        return output
    end,
    ---@return boolean
    current_location_is_in_lua_table = function()
        local language = 'lua'
        local node_at_cursor = vim.treesitter.get_node()

        local self = node_at_cursor:type()
        local parent = node_at_cursor:parent():type()
        local grandparent = node_at_cursor:parent():parent():type()

        local nodes = {
            self = self,
            parent = parent,
            grandparent = grandparent,
            zreturnValue = inTable,
        }
        V(nodes)

        local inTable = false
        -- if self == 'identifier' and parent == 'field' then
        --     if grandparent == 'table_constructor' then
        --         inTable = true
        --     end
        -- elseif parent == 'table_constructor' then
        --     inTable = true
        -- elseif self == 'table_constructor' then
        --     inTable = true
        -- end
        if self == 'table_constructor' or parent == 'table_constructor' or grandparent == 'table_constructor' then
            inTable = true
        end

        local parent_node_chain = my_treesitter_functions.find_chain_to_parent_node(node_at_cursor)
        local parent_node_chain_types = {}
        for key, value in ipairs(parent_node_chain) do
            table.insert(parent_node_chain_types, value:type())
        end
        V(parent_node_chain_types)
        return inTable

        -- return node_at_cursor:type() == 'table_constructor'

        -- local parent_node = my_treesitter_functions.find_parent_node(node_at_cursor)
        --
        -- local checker = {
        --     first = {},
        --     second = {},
        -- }
        -- local inTable = false
        -- for k, v in ipairs(parent_node_chain) do
        --     table.insert(checker.first, v:type())
        --     if v:type() == 'table_constructor' then
        --         inTable = true
        --     end
        -- end
        --
        -- V(parent_node)
        -- for node, node_type in parent_node:iter_children() do
        --     table.insert(checker.second, node:type())
        -- end
        --
        -- V(string.format('Currently inside lua table: %s', tostring(inTable)))
        -- V(checker)
        --
        -- return inTable
    end,
}

local function test()
    print(1)
end

local table = {
    first = 1,
    second = function()
        print(1)
    end,
    third = bool,
    forth = {
        inner = 1,
    },
}

my_treesitter_functions.cs = {
    get_recent_var = function()
        local language = 'c_sharp'
        local query_recent_var_cs =
            vim.treesitter.query.parse(language, '(variable_declarator (identifier) @cs_variable)')
        local variable = get_recent_var_from_node(query_recent_var_cs, language)
        return variable
    end,
    get_test_function_names = function()
        local language = 'c_sharp'
        local functions = vim.treesitter.query.parse(
            language,
            '((method_declaration (attribute_list (attribute name: (identifier) @xUnitTest (#match? @xUnitTest "(Fact|Theory)"))) name: (identifier) @xUnitTestMethodName))'
        )
        local function_list = get_test_function_names(functions, language, '.*Tests.cs', 'xUnitTestMethodName')

        return function_list
    end,
    get_class_name = function()
        local language = 'c_sharp'
        local class_query = vim.treesitter.query.parse(
            language,
            '(class_declaration (modifier) @public_private name: (identifier) @class_name)'
        )

        local bufnr = vim.api.nvim_get_current_buf()
        local root = get_root(bufnr, language)
        local class_details = {}
        for id, node in class_query:iter_captures(root, bufnr, 0, -1) do
            local name = vim.treesitter.get_node_text(node, bufnr):gsub('"', ''):gsub('\'', '')
            local capture_group = class_query.captures[id]
            if capture_group == 'public_private' then
                class_details.modifier = name
            elseif capture_group == 'class_name' then
                class_details.class = name
            end
        end

        return class_details
    end,
}

my_treesitter_functions.c = {
    get_recent_var = function()
        local language = 'c'
        local query_recent_var_c = vim.treesitter.query.parse(
            language,
            'declarator: (init_declarator declarator: (identifier) @non_array) declarator: (array_declarator declarator: (identifier) @array)'
        )
        local variable = get_recent_var_from_node(query_recent_var_c, language)
        return variable
    end,
}

my_treesitter_functions.bash = {
    get_recent_var = function()
        local language = 'bash'
        local query_recent_var_bash =
            vim.treesitter.query.parse(language, '(variable_assignment name: (variable_name) @bash_variable)')
        local variable = get_recent_var_from_node(query_recent_var_bash, language)
        return variable
    end,
}

return my_treesitter_functions
