local M = {}

--- https://cplusplus.com/reference/cstdio/printf/
M.printf_format_modifier_search = '(%%%d*%.?%d*%w%w*)'

---Find all occurrences of format modifiers in a printf style string
---@param input string
---@return table The list of all format modifiers
M.printf_format_modifier_matcher = function(input)
    local output = {}
    for item in input:gmatch(M.printf_format_modifier_search) do
        table.insert(output, item)
    end
    return output
end

return M
