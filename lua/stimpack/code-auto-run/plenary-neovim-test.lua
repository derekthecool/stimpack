local M = {}

local function check_for_open_test_files()
  local test_files_found = 0
  for _, open_buffers in pairs(vim.fn.getbufinfo()) do
    if open_buffers.name:match('.*_spec%.lua') then
      test_files_found = test_files_found + 1
    end
  end

  if test_files_found > 0 then
    return true
  else
    vim.notify('Error, no neovim test files (_spec.lua) found in open buffers', vim.log.levels.ERROR)
    return false
  end
end

M.neovim_test = function()
  if not check_for_open_test_files() then
    return
  end

  -- local buffer_number = vim.api.nvim_get_current_buf()
  local namespace_id = vim.api.nvim_create_namespace('neovim plenary lua test runner')

  local output_list = {}
  local test_file_buffers = {}

  for _, buffer in pairs(vim.fn.getbufinfo()) do
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
          test_filename = possible_match
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
      end
    end,

    on_exit = function()
      V(output_list)

      local test_names = require('stimpack.my-treesitter-functions').lua.get_test_function_names()
      for _, test_name in pairs(test_names) do
        for _, output_results_test_name in pairs(output_list) do
          if test_name.name == output_results_test_name.test_name then
            -- TODO: test line is not getting set with multiple test files
            output_results_test_name['test_line'] = test_name.test_line
          end
        end
      end

      for _, test_result in pairs(output_list) do
        -- Make sure table is not empty first
        if next(test_result.buffer_number) ~= nil then
          if test_result.result == 'Success' then
            -- V(test_result.test_line)
            local ext_mark_text = '    ✔️'
            -- vim.api.nvim_buf_set_extmark(
            --   test_result.buffer_number[1].bufnr,
            --   namespace_id,
            --   test_result.test_line,
            --   0,
            --   {
            --     virt_text = { { ext_mark_text, 'DevIconMotoko' } },
            --   }
            -- )
          elseif test_result.result == 'Fail' then
            local diagnostic_message = {
              {
                bufnr = test_result.buffer_number[1].bufnr,
                lnum = test_result.test_line,
                col = 0,
                severity = vim.diagnostic.severity.ERROR,
                source = 'neovim lua test',
                message = 'Test Failed ❌',
                user_data = {},
              },
            }
            -- V(test_result.buffer_number[1].bufnr)
            vim.diagnostic.set(namespace_id, test_result.buffer_number[1].bufnr, diagnostic_message, {})
          end
        end
      end
    end,
  })
end

return M
