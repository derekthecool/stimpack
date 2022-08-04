local foreground = "#FF0033"
local background = "#009933"
local cmd        = 'highlight MyCoolHighlight guifg=' .. foreground .. ' guibg=' .. background
vim.api.nvim_set_hl(0, "Comment", { fg = '#111111', bold = true, bg = '#999999' })

print(cmd)

vim.api.nvim_command(cmd)

vim.api.nvim_buf_add_highlight(0, 1, 'MyCoolHighlight', 2, 0, -1)
