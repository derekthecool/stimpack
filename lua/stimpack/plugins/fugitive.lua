local fugitive_git_level = 1
return {
    'tpope/vim-fugitive',
    keys = {
        {
            -- Set as third git plugin
            '<leader>g' .. fugitive_git_level,
            '<cmd>G<CR>',
            desc = 'Vim fugitive',
        },
    },
    config = function()
        vim.api.nvim_create_autocmd('BufEnter', {
            pattern = { 'fugitive:*' },
            callback = function()
                -- Mappings to use fugitive to push and pull
                vim.keymap.set('n', '<leader>gP', ':G push<CR>')
                vim.keymap.set('n', '<leader>gp', ':G pull<CR>')

                local fugitive_user_group = vim.api.nvim_create_augroup('fugitive_user_group', { clear = true })
                -- Change to file type detection of ft=fugitive to run command start insert
                vim.api.nvim_create_autocmd('BufNew', {
                    pattern = { '*COMMIT_EDITMSG' },
                    callback = function()
                        V('in commit')
                        vim.api.nvim_feedkeys('i', 'n', nil)
                    end,
                    group = fugitive_user_group,
                })
            end,
        })
    end,
}
