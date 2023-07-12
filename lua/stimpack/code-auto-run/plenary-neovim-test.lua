local M = {}

local function check_for_open_test_files()
    local test_files_found = 0
    for _, open_buffers in pairs(vim.fn.getbufinfo({ buflisted = true })) do
        if open_buffers.name:match('.*_spec%.lua') then
            test_files_found = test_files_found + 1
        end
    end

    if test_files_found > 0 then
        return true
    else
        return false
    end
end

M.neovim_test = function()
    if not check_for_open_test_files() then
        return
    end

    local namespace_id = vim.api.nvim_create_namespace('neovim plenary lua test runner')

    local output_list = {}
    local summary = {}
    local test_file_buffers = {}

    for _, buffer in pairs(vim.fn.getbufinfo({ buflisted = true })) do
        vim.api.nvim_buf_clear_namespace(buffer.bufnr, namespace_id, 0, -1)
        vim.diagnostic.reset(namespace_id, buffer.bufnr)

        if buffer.name:match('.*_spec%.lua') then
            table.insert(test_file_buffers, buffer)
        end
    end

    vim.notify('Starting neovim lua tests')

    vim.fn.jobstart('nvim --headless -c "PlenaryBustedDirectory ."', {
        stdout_buffered = true,
        on_stdout = function(_, data)
            if not data then
                return
            end

            local test_filename = nil
            local test_file_match_query = 'Testing:%s+(.*)%s+'
            for _, line in ipairs(data) do
                local possible_match = line:match(test_file_match_query)
                if possible_match ~= nil then
                    test_filename = possible_match:gsub('\t', '')
                end

                local test_output = {}
                test_output.result, test_output.test_group, test_output.test_name =
                    line:match('.-m(%w+)%c.-\t.-\t(.* --) (.*)\t')

                if test_filename ~= nil then
                    test_output.filename = test_filename
                    test_output.buffer_number = vim.fn.getbufinfo(test_filename)
                    if test_output.result ~= nil then
                        table.insert(output_list, test_output)
                    end
                end

                -- TODO: if running multiple plenary test files these numbers need to be added together
                local success_total = line:match('Success.*:.*(%d+)')
                if success_total ~= nil then
                    summary.success = success_total
                end

                local failure_total = line:match('Failed.*:.*(%d+)')
                if failure_total ~= nil then
                    summary.failure = failure_total
                end

                local error_total = line:match('Errors.*:.*(%d+)')
                if error_total ~= nil then
                    summary.error = error_total
                end
            end
            StimpackTestSummary = summary
        end,
        on_exit = function()
            local test_names = require('stimpack.my-treesitter-functions').lua.get_test_function_names()

            -- -- Uncomment for easy debugging
            -- vim.notify(vim.inspect(test_names))
            -- vim.notify(vim.inspect(output_list))

            local error_diagnostic_list = {}

            for _, test_result in pairs(output_list) do
                if test_result ~= nil and test_result.test_name ~= nil and test_names[test_result.test_name] ~= nil then
                    test_result['treesitter_details'] = test_names[test_result.test_name]
                else
                    result_check = type(test_result)
                    name_check = type(test_result.test_name) == nil
                    testname_check = type(test_names[test_result.test_name])
                    vim.notify(
                        string.format(
                            'Error with neovim plenary test: %s, cannot link the treesitter_details. result_check = %s, name_check = %s, testname_check = %s',
                            test_result.test_name,
                            result_check,
                            name_check,
                            testname_check
                        ),
                        vim.log.levels.ERROR,
                        { title = 'Stimpack Notification' }
                    )
                    return
                end

                -- Make sure table is not empty first
                if next(test_result.buffer_number) ~= nil then
                    if test_result.result == 'Success' then
                        vim.api.nvim_buf_set_extmark(
                            test_result.buffer_number[1].bufnr,
                            namespace_id,
                            test_result.treesitter_details.range[1],
                            0,
                            {
                                virt_text = { { Icons.diagnostics.success, 'DevIconMotoko' } },
                            }
                        )
                    elseif test_result.result == 'Fail' then
                        local diagnostic_message = {
                            bufnr = test_result.buffer_number[1].bufnr,
                            lnum = test_result.treesitter_details.range[1],
                            col = 0,
                            severity = vim.diagnostic.severity.ERROR,
                            source = 'neovim lua test',
                            message = string.format('Test Failed %s', Icons.diagnostics.error2),
                            user_data = {},
                        }
                        -- table.insert(error_diagnostic_list, diagnostic_message)
                        local buffer = test_result.buffer_number[1].bufnr

                        -- Create a table for each buffer
                        error_diagnostic_list[buffer] = error_diagnostic_list[buffer] or {}
                        table.insert(error_diagnostic_list[buffer], diagnostic_message)
                    end
                end
            end

            for buffer_number, diagnostic_table in pairs(error_diagnostic_list) do
                -- V(buffer_number, diagnostic_table)
                vim.diagnostic.set(namespace_id, buffer_number, diagnostic_table, {})
            end
        end,
    })
end

return M
