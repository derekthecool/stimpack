local M = {}

M.neovim_test = function()
  local buffer_number = vim.api.nvim_get_current_buf()
  local namespace_id = vim.api.nvim_create_namespace('neovim plenary lua test runner')

  vim.api.nvim_buf_clear_namespace(buffer_number, namespace_id, 0, -1)
  vim.diagnostic.reset(namespace_id, buffer_number)

  local output_list = {}

  vim.fn.jobstart('nvim --headless -c "PlenaryBustedDirectory lua/tests/"', {
    stdout_buffered = true,
    on_stdout = function(_, data)
      if not data then
        return
      end

      for _, line in ipairs(data) do
        table.insert(output_list, line)
      end
    end,

    on_exit = function()
      V(output_list)
    end,
  })
end

return M
