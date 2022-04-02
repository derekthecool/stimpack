local ls = require("luasnip")
local query = require("query")
-- some shorthands...
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local l = require("luasnip.extras").lambda
local rep = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local types = require("luasnip.util.types")
local conds = require("luasnip.extras.expand_conditions")

ls.config.set_config {
  history = true,
  update_events = "TextChanged,TextChangedI", -- update text as you type
  enable_autosnippets = true,
}

ls.snippets = {
	-- When trying to expand a snippet, luasnip first searches the tables for
	-- each filetype specified in 'filetype' followed by 'all'.
	-- If ie. the filetype is 'lua.c'
	--     - luasnip.lua
	--     - luasnip.c
	--     - luasnip.all
	-- are searched in that order.
	all = {
  },
  lua = {
    ls.parser.parse_snippet("lf", "local $1 = function($2)\n  $0\nend"),
  },
	vimwiki = {
		s("qy", {
			t({ "```yaml"}),
			i(1),
			t({ "```"}),
		}),
	},
}

local map = require('user.mapping-function')
map("i", "<c-j>", "<cmd>lua require'luasnip'.jump(1)<CR>")
map("s", "<c-j>", "<cmd>lua require'luasnip'.jump(1)<CR>")
map("i", "<c-k>", "<cmd>lua require'luasnip'.jump(-1)<CR>")
map("s", "<c-k>", "<cmd>lua require'luasnip'.jump(-1)<CR>")
