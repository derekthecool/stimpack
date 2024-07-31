describe('stimpack.boosters boolean flipper --', function()
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

    it('Require the file', function()
        assert.has_no_errors(function()
            require('stimpack.boosters.boolean-flipper')
        end)
    end)

    it('Flip boolean should return true if a single boolean is present', function()
        local toggle = require('stimpack.boosters.boolean-flipper').toggle('true')
        assert.are.same(toggle.flipped, true)
    end)

    it('Flip boolean should return false if a two or more boolean is present', function()
        local toggle = require('stimpack.boosters.boolean-flipper').toggle('true true true false')
        assert.are.same(toggle.flipped, false)
    end)

    it('Flip boolean string true should turn to false', function()
        local inputString = 'this is a line of text that contains the word true'
        local output = require('stimpack.boosters.boolean-flipper').toggle(inputString)

        assert.are.same(output.text, inputString:gsub('true', 'false'))
    end)

    it('Flip boolean string false should turn to true', function()
        local inputString = 'this is a line of text that contains the word false'
        local output = require('stimpack.boosters.boolean-flipper').toggle(inputString)

        assert.are.same(output.text, inputString:gsub('false', 'true'))
    end)

    -- end test group
end)
