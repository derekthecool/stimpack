-- Read current settings
local colors = vim.api.nvim_exec('colorscheme', true)
local background = vim.o.background
print(colors, background)

local count = 0
local count1 = 0
local count2 = 0
-- List all available colorschemes (and exclude light themes)
local all_colors = vim.fn.getcompletion('', 'color')
for _, color in pairs(all_colors) do
    for match in string.gmatch(color, '.*[^light-]+') do
        print(match)
        count = count + 1
    end

    for match in string.gmatch(color, '%w+-%w+-%w+') do
        print(match)
        count1 = count1 + 1
    end

    if not color:match('-light') then
        print(color)
        count2 = count2 + 1
    end
end
print(count, count1, count1)
