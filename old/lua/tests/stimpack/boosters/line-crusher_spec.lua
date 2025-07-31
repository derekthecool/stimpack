describe('Stimpack line-crusher --', function()
    before_each(function()
        -- Run time path is not getting loaded automatically, so modify it before each test
        print('Attempting to add to neovim runtime path with current plugin location')
        local path_to_plugin = debug.getinfo(1).source:match('@(.*[/\\]lua[/\\])'):gsub('"', '')
        print(
            string.format(
                'Attempting to add: %s to neovim runtimepath because plenary tests fail without this',
                path_to_plugin
            )
        )
        vim.cmd('set runtimepath+=' .. path_to_plugin)
    end)

    local crush = require('stimpack.boosters.line-crusher')

    it('Require the file', function()
        assert.has_no_errors(function()
            require('stimpack.boosters.line-crusher')
        end)
    end)

    -- TODO: issues with buffer text, fix me
    it('crush_current_line text should remain unchanged', function()
        -- Create new temp file
        local buffer = vim.api.nvim_create_buf(true, true)
        print(string.format('Test buffer number is = %d', buffer))
        print(buffer)
        assert.is_not.equal(buffer, 0)

        -- Set text width to 80 chars
        vim.opt.textwidth = 80

        -- Set exactly 80 chars of text
        local line = { 'wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww' }
        vim.api.nvim_buf_set_lines(buffer, 0, 0, true, line)
        vim.cmd('normal gg')

        -- Run crush_current_line
        crush.crush_current_line(buffer)

        -- Verify that file still only has one line
        local lines = vim.api.nvim_buf_get_lines(buffer, 0, -1, true)
        print(vim.inspect(line))
        print(line)
        print(vim.inspect(lines))
        print(lines)

        -- This checks value for equality
        assert.are.same(line, lines)

        -- This checks reference equality, which should not match
        assert.is_not.equal(line, lines)

        -- Optionally check that contents are the same as well

        -- Dummy test for now
        -- assert.has_no_errors(function()
        --     crush.crush_current_line()
        -- end)
    end)
end)
