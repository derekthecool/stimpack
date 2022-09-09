local get_root = function(bufnr)
  local parser = vim.treesitter.get_parser(bufnr, 'lua', {})
  local tree = parser:parse()[1]
  return tree:root()
end

local my_query = vim.treesitter.parse_query('lua', '(variable_list) @variable')
local bufnr = vim.api.nvim_get_current_buf()
local root = get_root(bufnr)

for id, node in my_query:iter_captures(root, bufnr, 0, -1) do
  -- Print node details
  print(vim.treesitter.get_node_text(node,bufnr), node:range())
  --  {start row, start col, end row, end col}
  local node_text = vim.treesitter.get_node_text(node, bufnr)
  print(node_text, { node:range() })
end

local current_row = vim.api.nvim_win_get_cursor(0)
print(current_row)
local closest_row_above = 1000
for id, node in my_query:iter_captures(root, bufnr, 0, -1) do
  local _, _, row, _ = node:range()
  if row < current_row[1] then
    closest_row_above  = row
    print(vim.treesitter.get_node_text(node, bufnr))
  end
end

print(closest_row_above)
