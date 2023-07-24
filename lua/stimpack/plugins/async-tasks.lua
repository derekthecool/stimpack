return {
    'skywind3000/asynctasks.vim',
    dependencies = {
        'skywind3000/asyncrun.vim',
    },
    -- Lazy loading settings
    keys = {
        { '<leader>uu', desc = 'AsyncTask project-run' },
        { '<leader>u;', desc = 'AsyncTask project-build' },
        { '<leader>ue', desc = 'AsyncTaskEdit' },
    },
    config = function()
        vim.g.asyncrun_open = 6
        vim.g.asyncrun_rootmarks = { '.git', '.svn', '.root', '.project', '.hg', '.exercism' }
        vim.keymap.set('n', '<leader>uu', function()
            vim.api.nvim_cmd({ cmd = 'AsyncTask', args = { 'project-run' } }, {})
        end, { silent = true, desc = 'My awesome AsyncTask: project-run' })
        vim.keymap.set('n', '<leader>u;', function()
            vim.api.nvim_cmd({ cmd = 'AsyncTask', args = { 'project-build' } }, {})
        end, { silent = true, desc = 'My awesome AsyncTask: project-build' })
        vim.keymap.set('n', '<leader>ue', function()
            vim.api.nvim_cmd({ cmd = 'AsyncTaskEdit' }, {})
        end, { silent = true, desc = 'AsyncTaskEdit' })
    end,
}
