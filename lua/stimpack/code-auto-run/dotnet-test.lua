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
    local buffer_number = vim.api.nvim_get_current_buf()
    local namespace_id = vim.api.nvim_create_namespace('dotnet_test_runner')

    vim.api.nvim_buf_clear_namespace(buffer_number, namespace_id, 0, -1)
    vim.diagnostic.reset(namespace_id, buffer_number)

    local dotnet_test_command = 'dotnet test --logger trx'
    vim.notify(string.format('Starting dotnet test: cmd="%s"', dotnet_test_command))

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
            end
        end,

        on_exit = function()
            if not output_log_filename then
                output_log_filename = 'nil'
            else
                local pass_fail_results = {}
                local buffer_function_names = require('stimpack.my-treesitter-functions').cs.get_function_names()

                -- Example log line: <UnitTestResult executionId="e1462b02-1118-4df7-9b9d-685e5f0abb7a" testId="7d2eee53-b992-539e-fa8b-ec839a51b1f9" testName="TestXUnit.UnitTest1.Test2" computerName="DerekLomax" duration="00:00:00.0057145" startTime="2022-09-07T11:32:32.2976422-06:00" endTime="2022-09-07T11:32:32.2976727-06:00" testType="13cdc9d9-ddb5-4fa4-a97d-d965ccfc6d4b" outcome="Passed" testListId="8c84fa94-04c1-424b-9868-57a2d4851a1d" relativeResultsDirectory="e1462b02-1118-4df7-9b9d-685e5f0abb7a" />
                -- TODO: use lua rock package for xml reading for better results
                for line in io.lines(output_log_filename) do
                    local test_name, test_result =
                        line:match('.*UnitTestResult.*testName=".-%.(%w+)["(].*outcome="(.-)"')
                    if test_name ~= nil and test_result ~= nil then
                        local current_test = { name = test_name, result = test_result }
                        local possible_test_location = buffer_function_names[test_name]
                        if possible_test_location ~= nil then
                            current_test.location = possible_test_location
                        end
                        table.insert(pass_fail_results, current_test)
                    end
                end

                for _, test in ipairs(pass_fail_results) do
                    -- If test passed put a virtual check mark with a purple highlight
                    if test.result == 'Passed' then
                        vim.api.nvim_buf_set_extmark(buffer_number, namespace_id, test.location[3], 0, {
                            virt_text = { { Icons.diagnostics.success, 'DevIconMotoko' } },
                        })
                    -- If test failed then use vim diagnostic to show the error
                    elseif test.result == 'Failed' then
                        local diagnostic_message = {
                            {
                                bufnr = buffer_number,
                                lnum = test.location[3],
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
        end,
    })
end

return M
