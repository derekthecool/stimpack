local M = {}

M.dotnet_test = function()
  local output_log_filename = nil
  local pass_fail_results = {}

  vim.fn.jobstart('dotnet test --logger trx', {
    stdout_buffered = true,
    on_stdout = function(_, data)
      if not data then
        return
      end

      for _, line in ipairs(data) do
        -- output_log_filename = line
        if string.match(line, 'Results File') then
          output_log_filename = line:match('Results File: (.*trx)')
        end
      end
    end,

    on_exit = function()
      if not output_log_filename then
        output_log_filename = 'nil'
      else
        -- local test_log_file = io.open(output_log_filename, 'r')
        -- <UnitTestResult executionId="e1462b02-1118-4df7-9b9d-685e5f0abb7a" testId="7d2eee53-b992-539e-fa8b-ec839a51b1f9" testName="TestXUnit.UnitTest1.Test2" computerName="DerekLomax" duration="00:00:00.0057145" startTime="2022-09-07T11:32:32.2976422-06:00" endTime="2022-09-07T11:32:32.2976727-06:00" testType="13cdc9d9-ddb5-4fa4-a97d-d965ccfc6d4b" outcome="Passed" testListId="8c84fa94-04c1-424b-9868-57a2d4851a1d" relativeResultsDirectory="e1462b02-1118-4df7-9b9d-685e5f0abb7a" />
        for line in io.lines(output_log_filename) do
          local test_name, test_result = line:match('.*UnitTestResult.*testName="(.-)".*outcome="(.-)"')
          if test_name ~= nil and test_result ~= nil then
            print(test_name, test_result)
            table.insert(pass_fail_results, { name = test_name, result = test_result })
          end
        end

        vim.notify(vim.inspect(pass_fail_results))
      end
      -- print('Dotnet test command complete, output_log_filename = ' .. output_log_filename)
    end,
  })
end

return M
