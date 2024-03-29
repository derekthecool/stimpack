describe('log-timestamp-visualizer --', function()
    -- before_each(function()
    --     -- Run time path is not getting loaded automatically, so modify it before each test
    --     print('Attempting to add to neovim runtime path with current plugin location')
    --     local path_to_plugin = debug.getinfo(1).source:match('@(.*[/\\]lua[/\\])'):gsub('"', '')
    --     print(
    --         string.format(
    --             'Attempting to add: %s to neovim runtimepath because plenary tests fail without this',
    --             path_to_plugin
    --         )
    --     )
    --     vim.cmd('set runtimepath+=' .. path_to_plugin)
    -- end)

    it('Require the file', function()
        assert.has_no_errors(function()
            require('stimpack.boosters.log-timestamp-visualizer')
        end)
    end)
end)
