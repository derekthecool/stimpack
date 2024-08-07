-- Visual settings
vim.o.termguicolors = true -- Needed for better color display
vim.o.cmdheight = 1

vim.opt.showtabline = 2
-- vim.api.nvim_set_hl(0, 'TabLine', { bg = 'none' })
-- vim.api.nvim_set_hl(0, 'TabLineFill', { link = 'Normal' })
-- vim.api.nvim_set_hl(0, 'TabLineSel', { fg = '#7d14ff' })

-- Set the chars that are displayed for trailing whitespace, line overflows, and tab chars
vim.wo.list = true -- enable the feature
vim.go.listchars = 'trail:·,precedes:«,extends:»,tab: ' -- specify chars
vim.opt.fillchars = 'fold: ,diff:,foldclose:,foldopen:,eob:▎'

vim.api.nvim_set_hl(0, 'WinSeparator', { bg = 'none' })

vim.api.nvim_set_hl(0, 'FloatBoarder', { fg = '#ffffff' })

-- Set highlight for mini.nvim trailspace
vim.api.nvim_set_hl(0, 'MiniTrailspace', { bg = '#4a50fa', fg = '#000000' })

-- Function to select a color scheme from my installed list with some filtering
function NewRandomColorscheme()
    local color_list = {}
    local all_colors = vim.fn.getcompletion('', 'color')
    for _, color in pairs(all_colors) do
        if not color:match('-light') then
            table.insert(color_list, #color_list, color)
        end
    end

    local random_index = math.random(1, #color_list)
    local new_color = color_list[random_index]
    vim.notify('Setting colorscheme to: ' .. new_color)
    vim.api.nvim_cmd({ cmd = 'colorscheme', args = { new_color } }, {})
end
