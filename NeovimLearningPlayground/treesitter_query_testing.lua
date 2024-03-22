local yo

local query_from_file = vim.treesitter.query.get('lua', 'test_query')

local get_root = function(bufnr)
    local parser = vim.treesitter.get_parser(bufnr, 'lua', {})
    local tree = parser:parse()[1]
    return tree:root()
end

local bufnr = vim.api.nvim_get_current_buf()
local root = get_root(bufnr)

for id, node in query_from_file:iter_captures(root, bufnr, 0, -1) do
    -- Print node details
    print(vim.treesitter.get_node_text(node, bufnr), node:range())
    --  {start row, start col, end row, end col}
    local node_text = vim.treesitter.get_node_text(node, bufnr)
    print(node_text, { node:range() })
end
