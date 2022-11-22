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


-- |>
vim.api.nvim_buf_set_extmark(bufnr, namespace, 48, 3, {
    -- virt_text_win_col = (window_width / 2) - 20,
    virt_text_pos = 'overlay',
    virt_text = { { '😄', 'GoodHappyGreen' } },
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

local plain_steno_start_row = 70
local plain_steno_start_col = 5

local plain_steno = {
    '#STPH*FPLTD',
    '#SKWR*RBGSZ',
    '   AO EU   ',
}

local function format_hex(number)
    return string.format('#%.6X', number)
end

local hex_color = 0x000000
print(format_hex(hex_color))

for i = 1, 30 do
    vim.api.nvim_set_hl(0, 'hl' .. i, { fg = format_hex(hex_color), bg = format_hex(math.random(0x888888)) })
    hex_color = hex_color + 1000
end

local highlight_count = 1
for k, v in ipairs(plain_steno) do
    local char_column = 0
    for char in v:gmatch('.') do
        vim.api.nvim_buf_set_extmark(bufnr, namespace, plain_steno_start_row + k, plain_steno_start_col + char_column, {
            virt_text_pos = 'overlay',
            virt_text = { { char, 'hl' .. highlight_count } },
        })
        char_column = char_column + 1
        highlight_count = highlight_count + 1
    end
end

local fancy_steno_start_row = 105
local fancy_steno_start_col = 5

local fancy_steno = {
    '+-+-+-+-+-+-+-+-+-+-+-+',
    '|#|S|T|P|H|*|F|P|L|T|D|',
    '+-+-+-+-+-+-+-+-+-+-+-+',
    '|#|S|K|W|R|*|R|B|G|S|Z|',
    '+-+-+-+-+-+-+-+-+-+-+-+',
    '      |A|O| |E|U|      ',
    '      +-+-+ +-+-+      ',
}


local window_height = vim.api.nvim_win_get_height(0)
local window_width = vim.api.nvim_win_get_width(0)
local cursor_row = vim.api.nvim_win_get_cursor(0)[1]
print(window_height, window_width, cursor_row)

vim.api.nvim_buf_set_extmark(bufnr, namespace, math.floor(cursor_row - window_height / 2), 0, {
    virt_text_win_col = (window_width / 2) - 20,
    virt_text_pos = 'overlay',
    virt_text = { { 'Derek is cool!', 'GoodHappyGreen' } },
})

vim.api.nvim_set_hl(0, 'FancyStenoBorder', { fg = '#6c25be', bg = '#39028d' })
vim.api.nvim_set_hl(0, 'FancyStenoActive', { fg = '#222222', bg = '#22ffff', bold = true, italic = true })
vim.api.nvim_set_hl(0, 'FancyStenoInactive', { bg = '#000000' })

print(fancy_steno[#fancy_steno])
for row, row_text in ipairs(fancy_steno) do
    -- for row=1,(#fancy_steno + 1) do
    local char_column = 0
    print(fancy_steno[row])
    for char in fancy_steno[row]:gmatch('.') do
        if char:match('[%+%-%| ]') then
            highlight = 'Title'
        else
            local steno_key = char:match('[A-Z#*]')
            if steno_key ~= nil and steno_key:match('[STG]') then
                highlight = 'FancyStenoActive'
            else
                highlight = 'Folded'
            end
        end

        vim.api.nvim_buf_set_extmark(
            bufnr,
            namespace,
            fancy_steno_start_row + (row - 1),
            fancy_steno_start_col + char_column,
            {
                virt_text_pos = 'overlay',
                virt_text = { { char, highlight } },
            }
        )
        char_column = char_column + 1
    end
end
