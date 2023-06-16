local M = {}
local s = function() return require("luasnip.nodes.snippet").S end
local sn = function() return require("luasnip.nodes.snippet").SN end
local isn = function() return require("luasnip.nodes.snippet").ISN end
local t = function() return require("luasnip.nodes.textNode").T end
local i = function() return require("luasnip.nodes.insertNode").I end
local f = function() return require("luasnip.nodes.functionNode").F end
local c = function() return require("luasnip.nodes.choiceNode").C end
local d = function() return require("luasnip.nodes.dynamicNode").D end
local r = function() return require("luasnip.nodes.restoreNode").R end
local events = function() return require("luasnip.util.events") end
local ai = function() return require("luasnip.nodes.absolute_indexer") end
local extras = function() return require("luasnip.extras") end
local l = function() return require("luasnip.extras").lambda end
local rep = function() return require("luasnip.extras").rep end
local p = function() return require("luasnip.extras").partial end
local m = function() return require("luasnip.extras").match end
local n = function() return require("luasnip.extras").nonempty end
local dl = function() return require("luasnip.extras").dynamic_lambda end
local fmt = function() return require("luasnip.extras.fmt").fmt end
local fmta = function() return require("luasnip.extras.fmt").fmta end
local conds = function() return require("luasnip.extras.expand_conditions") end
local postfix = function() return require("luasnip.extras.postfix").postfix end
local types = function() return require("luasnip.util.types") end
local parse = function() return require("luasnip.util.parser").parse_snippet end
local ms = function() return require("luasnip.nodes.multiSnippet").new_multisnippet end

M.printf_style_dynamic_formatter = function(jump_position)
    return d(nil, function(args, snip)
        local printf_dynamic_node = {}
        table.insert(printf_dynamic_node, t('"'))
        table.insert(printf_dynamic_node, i(1))
        table.insert(printf_dynamic_node, t('"'))

        return sn(nil, printf_dynamic_node)
    end, { 1 })
end

return M
