-- Start example text and code (intended for writing virtual text and symbols on)

local variable = 4

local my_table = {
  first = 1,
  second = 2,
}

local function test_my_code()
  return 4
end

print(test_my_code())

-- End example text

vim.api.nvim_set_hl(0, 'GoodHappyGreen', { fg = '#00ff00', bg = '', bold = true, undercurl = false })
vim.api.nvim_set_hl(0, 'Gray', { fg = '#554433', bg = '', bold = false, undercurl = false })

local bufnr = vim.api.nvim_get_current_buf()
-- Namespace cannot be empty
local namespace = vim.api.nvim_create_namespace('extmark_test')
vim.api.nvim_buf_clear_namespace(bufnr, namespace, 0, -1)

local location = {
  { col = 2, row = 5 },
  { col = 0, row = 9 },
}

-- Test one place a symbol and test virtual text location placement
local ext_mark_text = '€'
vim.api.nvim_buf_set_extmark(bufnr, namespace, location[1].row, location[1].col, {
  virt_text_pos = 'eol', -- default value, not needed explicitly
  virt_text = { { ext_mark_text, 'DevIconMotoko' } },
})

vim.api.nvim_buf_set_extmark(bufnr, namespace, location[1].row, location[1].col, {
  virt_text_pos = 'overlay',
  virt_text = { { ext_mark_text, 'DevIconMotoko' } },
})

-- Luapad does not seem to support a highlight with a namespace
vim.api.nvim_buf_set_extmark(bufnr, namespace, location[1].row, location[1].col, {
  virt_text_pos = 'right_align',
  virt_text = { { ext_mark_text, 'GoodHappyGreen' } },
})

-- Test two: simulate Visual Studio test virtual texi and references to functions
local grayHighlight = 'Gray'
-- vim.api.nvim_set_hl(namespace, 'ATcommandHighlight', { bg = '#5fd700', fg = '#000000' })
vim.api.nvim_buf_set_extmark(bufnr, namespace, location[2].row, location[2].col, {
  virt_lines_above = true,
  virt_text = { { 'wow, virtual text and virtual lines???', 'DevIconMotoko' } },
  sign_text = '😬',
  sign_hl_group = 'DevIconMotoko',
  --[[ line_hl_group = 'Comment', -- this seems weird to highlight the whole line]]
  virt_lines = {
    {
      { '1 reference', grayHighlight },
      { ' | ', grayHighlight },
      { '☑️  ', 'GoodHappyGreen' },
      { '1/1 passing', grayHighlight },
    },
  },
})
