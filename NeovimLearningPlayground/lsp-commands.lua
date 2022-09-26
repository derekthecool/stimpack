-- TODO: find a way to check how many references to a function to variable are found. I want to copy visual Studio feature
local dog = 4
local function cow()
    return 8
end

--[[ local function request_callback(_, method, result)
  return {method, result}
end

local params = vim.lsp.util.make_position_params()
local a = vim.lsp.buf_request(0,"textDocument/definition", params, request_callback)
print(vim.inspect(request_callback))
print(params,a)
]]

local params = vim.lsp.util.make_position_params()
print(params)
vim.lsp.buf_request(0, 'textDocument/references', params, nil)
dog = 7
