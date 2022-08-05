-- Visual settings
vim.o.termguicolors = true -- Needed for better color display
vim.wo.cursorcolumn = true
vim.wo.colorcolumn = '80' -- Display color column at 80 characters

-- Set the chars that are displayed for trailing whitespace, line overflows, and tab chars
vim.wo.list = true -- enable the feature
vim.go.listchars = 'trail:·,precedes:«,extends:»,tab:▸\\ ' -- specify chars

-- vim.cmd "colorscheme base16-atelier-forest" -- Current color scheme
vim.cmd('colorscheme base16-atelier-sulphurpool') -- Former favorite

-- vim.cmd([[match ColorColumn /\s\+$/]]) -- Highlight trailing whitespace with color column

require('nvim-web-devicons').setup({
    -- globally enable default icons (default to false)
    -- will get overriden by `get_icons` option
    default = true,
})

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
    vim.cmd(string.format('colorscheme %s', new_color))
end
