local my_treesitter_functions = {}

vim.keymap.set('n', '<leader><leader>ab', function()
    package.loaded['stimpack.my-treesitter-functions'] = false
    V('Reloading my-treesitter-functions')
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

    if node ~= nil then
        table.insert(nodes, node)
    end

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

        local output = get_test_function_names(get_test_function_names_query, language, '.*_spec%.lua', 'test_name')
        return output
    end,
    --- Function to check if cursor is in lua table
    ---@return boolean
    current_location_is_in_lua_table = function()
        local node_at_cursor = vim.treesitter.get_node()
        local parent_node_chain = my_treesitter_functions.find_chain_to_parent_node(node_at_cursor)
        local maximumParentDepth = 3
        local table3 = {}

        local inTable = false
        for key, value in ipairs(parent_node_chain) do
            if key > maximumParentDepth then
                break
            end

            table.insert(table3, value:type())

            -- If node within range is a table_constructor, cursor is in a lua table
            if value:type() == 'table_constructor' then
                inTable = true
            end
        end

        if node_at_cursor:type() == 'function_definition' then
            inTable = false
            V('Current node is function_definition, set to false')
        end

        table.insert(table3, inTable)
        V(table3)

        return inTable
    end,
    isReloadWorking = function()
        print('yes')
    end,
}

local function test()
    print(1)
end

local table = {
    first = 1,
    second = function()
        print(1)
        local test = 4
    end,
    great = 12346,
    test = true,
    have = 1,
    tight = true,
    test = true,
    bylaw = true,
    my = {
        tang = {
            also = {
                will = false,
            },
        },
    },
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
