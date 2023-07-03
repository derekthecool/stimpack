local M = {}

-- stylua: ignore start
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
-- stylua: ignore end

M.printf_style_dynamic_formatter = function(jump_position)
    return d(jump_position, function(args, snip)
        local output = {}
        local test = args[1][1]
        local insert_location = 1
        if test then
            for format_modifier in test:gmatch('(%%%w)') do
                table.insert(output, t(','))
                table.insert(output, i(insert_location, string.format([['%s']], format_modifier)))
                insert_location = insert_location + 1
            end
        end
        return sn(nil, output)
    end, { 1 })
end

-- Start dynamic_node with user input
-- https://github.com/L3MON4D3/LuaSnip/wiki/Misc#dynamicnode-with-user-input
local ls = require('luasnip')
local util = require('luasnip.util.util')
local node_util = require('luasnip.nodes.util')

local function find_dynamic_node(node)
    -- the dynamicNode-key is set on snippets generated by a dynamicNode only (its'
    -- actual use is to refer to the dynamicNode that generated the snippet).

    while not node.dynamicNode do
        -- V(node)
        node = node.parent
    end

    return node.dynamicNode
end

local external_update_id = 0

-- func_indx to update the dynamicNode with different functions.
function Dynamic_node_external_update(func_indx)
    -- most of this function is about restoring the cursor to the correct
    -- position+mode, the important part are the few lines from
    -- `dynamic_node.snip:store()`.

    -- find current node and the innermost dynamicNode it is inside.
    local current_node = ls.session.current_nodes[vim.api.nvim_get_current_buf()]
    local dynamic_node = find_dynamic_node(current_node)
    if not dynamic_node then
        return nil
    end

    -- to identify current node in new snippet, if it is available.
    external_update_id = external_update_id + 1
    current_node.external_update_id = external_update_id

    -- store which mode we're in to restore later.
    local insert_pre_call = vim.fn.mode() == 'i'
    -- is byte-indexed! Doesn't matter here, but important to be aware of.
    local cursor_pos_pre_relative = util.pos_sub(util.get_cursor_0ind(), current_node.mark:pos_begin_raw())

    -- leave current generated snippet.
    node_util.leave_nodes_between(dynamic_node.snip, current_node)

    -- call update-function.
    local func = dynamic_node.user_args[func_indx]
    if func then
        -- the same snippet passed to the dynamicNode-function. Any output from func
        -- should be stored in it under some unused key.
        func(dynamic_node.parent.snippet)
    end

    -- last_args is used to store the last args that were used to generate the
    -- snippet. If this function is called, these will most probably not have
    -- changed, so they are set to nil, which will force an update.
    dynamic_node.last_args = nil
    dynamic_node:update()

    -- everything below here isn't strictly necessary, but it's pretty nice to have.

    -- try to find the node we marked earlier.
    local target_node = dynamic_node:find_node(function(test_node)
        return test_node.external_update_id == external_update_id
    end)

    if target_node then
        -- the node that the cursor was in when changeChoice was called exists
        -- in the active choice! Enter it and all nodes between it and this choiceNode,
        -- then set the cursor.
        node_util.enter_nodes_between(dynamic_node, target_node)

        if insert_pre_call then
            util.set_cursor_0ind(util.pos_add(target_node.mark:pos_begin_raw(), cursor_pos_pre_relative))
        else
            node_util.select_node(target_node)
        end
        -- set the new current node correctly.
        ls.session.current_nodes[vim.api.nvim_get_current_buf()] = target_node
    else
        -- the marked node wasn't found, just jump into the new snippet noremally.
        ls.session.current_nodes[vim.api.nvim_get_current_buf()] = dynamic_node.snip:jump_into(1)
    end
end

-- end dynamic_node with user input
-- https://github.com/L3MON4D3/LuaSnip/wiki/Misc#dynamicnode-with-user-input

return M
