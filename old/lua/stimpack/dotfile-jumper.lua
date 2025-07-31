local dotfile_paths = {
    OS['vimwiki'],
    OS['nvim'],
    OS['plover'],
    OS['wezterm'],
    OS['CrossPlatformDotfiles'],
}

local dotfile_jump = function()
    vim.ui.select(dotfile_paths, {
        prompt = 'Which dotfile to jump to:',
        format_item = function(item)
            return 'Jump to: ' .. item
        end,
    }, function(choice, index)
        -- V(string.format('choice = %s, index = %d', choice, index))
        if not index then
            return
        end

        vim.api.nvim_cmd({ cmd = 'cd', args = { choice } }, {})
        vim.api.nvim_cmd({ cmd = 'e', args = { 'README.md' } }, {})
    end)
end

for _, value in pairs({ ',fd' }) do
    vim.keymap.set('n', value, function()
        dotfile_jump()
    end, { silent = true, desc = 'dotfile_jump' })
end
