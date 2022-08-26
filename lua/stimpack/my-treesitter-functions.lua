local my_treesitter_functions = {}

local get_root = function(bufnr)
  local parser = vim.treesitter.get_parser(bufnr, 'lua', {})
  local tree = parser:parse()[1]
  return tree:root()
end

local function get_recent_var(query)
  local bufnr = vim.api.nvim_get_current_buf()
  local root = get_root(bufnr)

  local current_row = vim.api.nvim_win_get_cursor(0)
  -- local closest_row_above = 1000
  local variable_name = ''
  for _, node in query:iter_captures(root, bufnr, 0, -1) do
    local _, _, row, _ = node:range()
    if row < current_row[1] then
      -- closest_row_above = row
      variable_name = vim.treesitter.get_node_text(node, bufnr)
    end
  end

  return variable_name
end

my_treesitter_functions.lua = {
  get_recent_var = function()
    local query_recent_var_lua = vim.treesitter.parse_query('lua', '(variable_list) @variable')
    return get_recent_var(query_recent_var_lua)
  end,
}

return my_treesitter_functions
