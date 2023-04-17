describe('Stimpack line-crusher --', function()
    before_each(function()
        -- Run time path is not getting loaded automatically, so modify it before each test
        --
        -- Project directory tree view:
        -- lua/
        -- ├── string-calculator
        -- │   ├── init.lua
        -- │   └── string-calculator-function.lua
        -- └── tests
        --     └── string-calculator
        --         └── string-calculator_spec.lua
        --
        -- Our test files are the '_spec.lua' files. So adding the directory 4 levels up will set our runtimepath properly.

        local path_to_plugin = debug.getinfo(1).source:match('@(.*)/.*/.*/.*/.*'):gsub('"', '')
        vim.cmd('set runtimepath+=' .. path_to_plugin)
        print(string.format('Adding: %s to neovim runtimepath because plenary tests fail without this', path_to_plugin))
    end)

    local crush = require('stimpack.boosters.line-crusher')

    it('Require the file', function()
        assert.has_no_errors(function()
            require('stimpack.boosters.line-crusher')
        end)
    end)

    it('crush_current_line text should remain unchanged', function()
        -- Create new temp file

        -- Set text width to 80 chars

        -- Set exactly 80 chars of text

        -- Run crush_current_line

        -- Verify that file still only has one line

        -- Optionally check that contents are the same as well

        -- Dummy test for now
        assert.has_no_errors(function()
            crush.crush_current_line()
        end)
    end)
end)
