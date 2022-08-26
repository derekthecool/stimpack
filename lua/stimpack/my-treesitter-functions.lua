local my_treesitter_functions = {}

local get_root = function(bufnr, language)
  local parser = vim.treesitter.get_parser(bufnr, language, {})
  local tree = parser:parse()[1]
  return tree:root()
end

local function get_recent_var_from_node(query, language)
  local bufnr = vim.api.nvim_get_current_buf()
  local root = get_root(bufnr, language)

  local current_row = vim.api.nvim_win_get_cursor(0)
  local variable_name = ''
  for _, node in query:iter_captures(root, bufnr, 0, -1) do
    print(node, 'test')
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
}

my_treesitter_functions.cs = {
  get_recent_var = function()
    local language = 'c_sharp'
    local query_recent_var_cs =
    vim.treesitter.parse_query(language, '(variable_declarator (identifier) @cs_variable)')
    local variable = get_recent_var_from_node(query_recent_var_cs, language)
    return variable
  end,
}

my_treesitter_functions.c = {
  get_recent_var = function()
    local language = 'c'
    local query_recent_var_c =
    vim.treesitter.parse_query(language, 'declarator: (init_declarator declarator: (identifier) @non_array) declarator: (array_declarator declarator: (identifier) @array)')
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
