-- Autotest runners
local dotnet_test = require('stimpack.code-auto-run.dotnet-test').dotnet_test

local autocommand_group = vim.api.nvim_create_augroup('code-auto-run', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {pattern= {'*test*.cs','*Test*.cs'}, callback = dotnet_test, group = autocommand_group})

return {
  dotnet_test = dotnet_test,
}
