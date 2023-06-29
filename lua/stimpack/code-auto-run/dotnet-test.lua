local M = {}

--[[
Dotnet test runner
Inspired by TJ DeVries https://www.youtube.com/watch?v=cf72gMBrsI0

Main process steps:
1. Run the command 'dotnet test' with desired args
2. Scan stdout for the output test result file name *.trx, save to variable
3. In the on_exit function for the dotnet command read from the the trx test
   result file and process tests.
4. Display results of pass fail in the test file using nvim_buf_set_extmark for
   passing tests and vim.diagnostic for failing tests.
]]
M.dotnet_test = function()
    local output_log_filename = nil
    local namespace_id = vim.api.nvim_create_namespace('dotnet_test_runner')

    local buffer_list = require('stimpack/my-treesitter-functions').all.get_all_buffers('.*Tests.cs', true)
    if #buffer_list == 0 then
        -- vim.notify('No open test files')
        return
    end

    for _, buffer_number in pairs(buffer_list) do
        vim.api.nvim_buf_clear_namespace(buffer_number, namespace_id, 0, -1)
        vim.diagnostic.reset(namespace_id, buffer_number)
    end

    local dotnet_test_command = 'dotnet test --logger trx'
    vim.notify(string.format('Starting dotnet test: cmd="%s"', dotnet_test_command))

    local error_list = {}

    vim.fn.jobstart(dotnet_test_command, {
        stdout_buffered = true,
        on_stdout = function(_, data)
            if not data then
                return
            end

            -- Scan the received data from stdout. Only looking for the filename that has test results
            for _, line in ipairs(data) do
                if string.match(line, 'Results File') then
                    output_log_filename = line:match('Results File: (.*trx)')
                end

                -- Example error message
                -- C:\Users\Derek Lomax\source\repos\Freeus.Tools\BelleDealerTasks\MqttHandler\Proto\ProtoParser.cs(58,10): error CS1002: ; expected [C:\Users\Derek Lomax\source\repos\Freeus.Tools\BelleDealerTasks\MqttHandler\MqttHandler.csproj]
                -- C:\\Users\\Derek Lomax\\source\\repos\\Freeus.Tools\\BelleDealerTasks\\MqttHandler\\Proto\\ProtoParser.cs(58,10): error CS1002: ; expected [C:\\Users\\Derek Lomax\\source\\repos\\Freeus.Tools\\BelleDealerTasks\\MqttHandler\\MqttHandler.csproj]
                if string.match(line, ': error ') then
                    local error_match = {
                        line:match('(.*)%((%d+),(%d+)%): error (..%d+): (.*)%['),
                    }
                    table.insert(error_list, error_match)
                end
            end
        end,
        on_exit = function(_, exit_code)
            if exit_code ~= 0 then
                vim.notify(
                    'Dotnet autotest runner failed to run tests',
                    vim.log.levels.ERROR,
                    { title = 'Stimpack dotnet autotest runner' }
                )

                -- TODO: set quick fix list here
                vim.notify(
                    vim.inspect(error_list),
                    vim.log.levels.ERROR,
                    { title = 'Stimpack dotnet autotest runner errors' }
                )
            end

            if not output_log_filename then
                output_log_filename = 'nil'
            else
                local pass_fail_results = {}
                local test_name_locations = require('stimpack.my-treesitter-functions').cs.get_test_function_names()

                -- Example log line: <UnitTestResult executionId="e1462b02-1118-4df7-9b9d-685e5f0abb7a" testId="7d2eee53-b992-539e-fa8b-ec839a51b1f9" testName="TestXUnit.UnitTest1.Test2" computerName="DerekLomax" duration="00:00:00.0057145" startTime="2022-09-07T11:32:32.2976422-06:00" endTime="2022-09-07T11:32:32.2976727-06:00" testType="13cdc9d9-ddb5-4fa4-a97d-d965ccfc6d4b" outcome="Passed" testListId="8c84fa94-04c1-424b-9868-57a2d4851a1d" relativeResultsDirectory="e1462b02-1118-4df7-9b9d-685e5f0abb7a" />
                -- TODO: use lua rock package for xml reading for better results
                for line in io.lines(output_log_filename) do
                    local test_name, test_result =
                        line:match('.*UnitTestResult.*testName=".-%.([%w_]+)["(].*outcome="(.-)"')
                    if test_name ~= nil and test_result ~= nil then
                        pass_fail_results[test_name] = {
                            name = test_name,
                            result = test_result,
                            ['treesitter_details'] = test_name_locations[test_name],
                        }
                    end
                end

                V(pass_fail_results)

                for _, test in pairs(pass_fail_results) do
                    if test.treesitter_details ~= nil and test.treesitter_details.bufnr ~= nil then
                        local buffer_number = test.treesitter_details.bufnr
                        -- If test passed put a virtual check mark with a purple highlight
                        if test.result == 'Passed' then
                            vim.api.nvim_buf_set_extmark(
                                buffer_number,
                                namespace_id,
                                test.treesitter_details.range[1],
                                0,
                                {
                                    virt_text = { { Icons.diagnostics.success, 'DevIconMotoko' } },
                                }
                            )
                            -- If test failed then use vim diagnostic to show the error
                        elseif test.result == 'Failed' then
                            local diagnostic_message = {
                                {
                                    bufnr = buffer_number,
                                    lnum = test.treesitter_details.range[1],
                                    col = 0,
                                    severity = vim.diagnostic.severity.ERROR,
                                    source = 'dotnet test',
                                    message = string.format('Test Failed %s', Icons.diagnostics.error2),
                                    user_data = {},
                                },
                            }
                            vim.diagnostic.set(namespace_id, buffer_number, diagnostic_message, {})
                        end
                    end
                end
            end
        end,
    })
end

return M
