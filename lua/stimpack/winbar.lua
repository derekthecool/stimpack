local M = {}

MacroWinbarIdentifier = ''

local function join_status_line(input, highlight, item)
    local output = input
    if highlight ~= nil then
        output = output .. '%#' .. highlight .. '#'
    end
    output = output .. item .. '%*'
    return output
end

function M.eval()
    local winbar = ''
    local file_path = vim.api.nvim_eval_statusline('%f', {}).str
    local modified = vim.api.nvim_eval_statusline('%M', {}).str == '+' and ' ⊚ ' or ''

    file_path = file_path:gsub('[/\\]+', Icons.ui.arrowclosed2)

    if not MacroWinbarIdentifier then
        MacroWinbarIdentifier = ''
    end

    if MacroWinbarIdentifier == nil or MacroWinbarIdentifier == '' then
        vim.api.nvim_set_hl(0, 'WinBar', { fg = '#7d14ff' })
        vim.api.nvim_set_hl(0, 'WinBarNC', { fg = '#444444' })
    end

    if modified == '' then
        winbar = join_status_line(winbar, nil, file_path)
    else
        winbar = join_status_line(winbar, 'DevIconLess', file_path .. modified)
    end

    winbar = join_status_line(winbar, nil, MacroWinbarIdentifier)

    return winbar
end

return M
