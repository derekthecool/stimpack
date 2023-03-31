local autocommand_group = vim.api.nvim_create_augroup('awesome-window-manager-config-checker', { clear = true })

-- Linux

-- Awesome window manager
vim.api.nvim_create_autocmd('BufWritePost', {
    pattern = { '*/awesome/rc.lua' },
    callback = function()
        local output = Execute('awesome --check')
        -- V(output)
        if output.ret ~= nil and output.ret == 0 then
            vim.notify('Awesome WM config OK!', vim.log.levels.INFO, { title = 'Stimpack Notification' })
        else
            vim.notify(
                'Awesome WM config failure, DO NOT RESTART AWESOME',
                vim.log.levels.ERROR,
                { title = 'Stimpack Notification' }
            )
        end
    end,
    group = autocommand_group,
})
