local my_treesitter_functions = {}

local get_root = function(bufnr, language)
  local parser = vim.treesitter.get_parser(bufnr, language, {})
  local tree = parser:parse()[1]
  return tree:root()
end

local function get_test_function_names(query, language)
  local bufnr = vim.api.nvim_get_current_buf()
  local root = get_root(bufnr, language)

  local test_function_locations = {}
  for id, node in query:iter_captures(root, bufnr, 0, -1) do
    local name = vim.treesitter.get_node_text(node, bufnr):gsub('"', ''):gsub('\'', '')
    table.insert(test_function_locations, {
      test_line = node:range(),
      node_capture_group = query.captures[id],
      name = name,
    })
  end
  return test_function_locations
end

local function get_function_names(query, language)
  local bufnr = vim.api.nvim_get_current_buf()
  local root = get_root(bufnr, language)

  local function_locations = {}
  for _, node in query:iter_captures(root, bufnr, 0, -1) do
    function_locations[vim.treesitter.get_node_text(node, bufnr)] = { node:range() }
  end
  return function_locations
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

my_treesitter_functions.lua = {
  get_recent_var = function()
    local language = 'lua'
    local query_recent_var_lua = vim.treesitter.parse_query(language, '(variable_list) @lua_variable')
    return get_recent_var_from_node(query_recent_var_lua, language)
  end,

  get_test_function_names = function()
    local language = 'lua'

    -- First attempt, this gets matches the function call of the "it" function call
    -- '((function_call name: (identifier) @test_function_name (#eq? @test_function_name "it")))'

    -- Better version to get the test name (location comes with it as well)
    -- ((function_call name: (identifier) @test_function_name (#eq? @test_function_name "it") arguments: (arguments (string)@test_name)))
    local get_test_function_names_query = vim.treesitter.parse_query(
      language,
      '((function_call name: (identifier) @test_function_name (#eq? @test_function_name "it") arguments: (arguments (string)@test_name)))'
    )

    -- V(get_test_function_names_query)
    local output = get_test_function_names(get_test_function_names_query, language)
    local final_output = {}

    for _, value in pairs(output) do
      if value.node_capture_group == 'test_name' then
        table.insert(final_output, value)
      end
    end
    return final_output
  end,
}

my_treesitter_functions.cs = {
  get_recent_var = function()
    local language = 'c_sharp'
    local query_recent_var_cs =
    vim.treesitter.parse_query(language, '(variable_declarator (identifier) @cs_variable)')
    local variable = get_recent_var_from_node(query_recent_var_cs, language)
    return variable
  end,

  get_function_names = function()
    local language = 'c_sharp'
    local functions =
    vim.treesitter.parse_query(language, '(method_declaration name: (identifier) @function_names)')
    local function_list = get_function_names(functions, language)
    return function_list
  end,
}

my_treesitter_functions.c = {
  get_recent_var = function()
    local language = 'c'
    local query_recent_var_c = vim.treesitter.parse_query(
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
    vim.treesitter.parse_query(language, '(variable_assignment name: (variable_name) @bash_variable)')
    local variable = get_recent_var_from_node(query_recent_var_bash, language)
    return variable
  end,
}

return my_treesitter_functions
