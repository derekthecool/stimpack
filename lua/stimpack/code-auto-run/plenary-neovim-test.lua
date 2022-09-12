local M = {}

M.neovim_test = function()
  local buffer_number = vim.api.nvim_get_current_buf()
  local namespace_id = vim.api.nvim_create_namespace('neovim plenary lua test runner')

  vim.api.nvim_buf_clear_namespace(buffer_number, namespace_id, 0, -1)
  vim.diagnostic.reset(namespace_id, buffer_number)

  local output_list = {}

  vim.notify('Starting neovim lua tests')

  vim.fn.jobstart('nvim --headless -c "PlenaryBustedDirectory ."', {
    stdout_buffered = true,
    on_stdout = function(_, data)
      if not data then
        return
      end

      for _, line in ipairs(data) do
        local test_output = {}
        test_output.result, test_output.test_group, test_output.test_name =
        line:match('.-m(%w+)%c.-\t.-\t(.* --) (.*)\t')
        if test_output.result ~= nil then
          table.insert(output_list, test_output)
        end
      end
    end,

    on_exit = function()
      local test_names = require('stimpack.my-treesitter-functions').lua.get_test_function_names()
      for _, test_name in pairs(test_names) do
        for _, output_results_test_name in pairs(output_list) do
          if test_name.name == output_results_test_name.test_name then
            output_results_test_name['test_line'] = test_name.test_line
          end
        end
      end

      for _, test_result in pairs(output_list) do
        if test_result.result == 'Success' then
          local ext_mark_text = '    ✔️'
          vim.api.nvim_buf_set_extmark(buffer_number, namespace_id, test_result.test_line, 0, {
            virt_text = { { ext_mark_text, 'DevIconMotoko' } },
          })
        elseif test_result.result == 'Fail' then
          local diagnostic_message = {
            {
              bufnr = buffer_number,
              lnum = test_result.test_line,
              col = 0,
              severity = vim.diagnostic.severity.ERROR,
              source = 'neovim lua test',
              message = 'Test Failed ❌',
              user_data = {},
            },
          }
          vim.diagnostic.set(namespace_id, buffer_number, diagnostic_message, {})
        end
      end
    end,
  })
end

return M
