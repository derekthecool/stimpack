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

vim.api.nvim_buf_set_extmark(bufnr, namespace, location[1].row, location[1].col, {
  virt_text_pos = 'right_align',
  virt_text = { { ext_mark_text, 'DevIconMotoko' } },
})

-- Test two: simulate Visual Studio test virtual text and references to functions
vim.api.nvim_buf_set_extmark(bufnr, namespace, location[2].row, location[2].col, {
  virt_lines_above = true,
  virt_lines = {
    { { 'references: 4 | Tests 3/4', 'DevIconMotoko' } },
  },
})
