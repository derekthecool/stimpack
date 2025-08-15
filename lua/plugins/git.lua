return {
    {
        -- TODO: (Derek Lomax) Fri Aug 15 11:01:58 2025, This plugin seems to be not Windows friendly
        -- Works in WSL though. Consider contributing to project.
        'ThePrimeagen/git-worktree.nvim',
        version = '^2',
        dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' },
        config = function()
            vim.keymap.set('n', '<leader>gw', function()
                local git_result = Execute('git worktree list')
                local worktrees = {}

                -- Load everything surrounded by [] into the list of worktrees
                for _, git_output in pairs(git_result.stdout) do
                    git_output:gsub('%[(%S+)%]', function(tree)
                        table.insert(worktrees, tree)
                    end)
                end

                vim.ui.select(worktrees, {
                    prompt = 'Select git worktree:',
                    format_item = function(item)
                        return item
                    end,
                }, function(choice)
                    if choice then
                        require('git-worktree').switch_worktree(choice)
                    end
                end)
            end, { desc = 'Select git worktree' })

            local function get_new_worktree_name()
                return vim.fn.input('Enter new git worktree name')
            end

            vim.keymap.set('n', '<leader>gm', function()
                local new_worktree = get_new_worktree_name()
                if not new_worktree then
                    return
                end

                require('git-worktree').create_worktree(new_worktree, new_worktree, 'origin')
            end, { silent = true, desc = 'Create new git worktree' })
        end,
    },
}
