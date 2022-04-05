local ls = require("luasnip")
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

local map = require('user.mapping-function')
map("i", "<c-j>", "<cmd>lua require'luasnip'.jump(1)<CR>")
map("s", "<c-j>", "<cmd>lua require'luasnip'.jump(1)<CR>")
map("i", "<c-k>", "<cmd>lua require'luasnip'.jump(-1)<CR>")
map("s", "<c-k>", "<cmd>lua require'luasnip'.jump(-1)<CR>")

vim.keymap.set("n", "<leader><leader>s", "<cmd>source ~/.config/nvim/lua/user/luasnip-settings.lua<cr>")

-- vim.keymap.set("i", "<c-s>", function()
--   if ls.choice_active() then
--     ls.change_choice(1)
--   end
-- end)
--
-- vim.keymap.set("i","s", "<c-s>", function()
--   if ls.choice_active() then
--     ls.change_choice(1)
--   end
-- end)

ls.add_snippets(nil, {
  lua = {
    s("ternary", {
        i(1, "cond"), t(" ? "), i(2, "then"), t(" : "), i(3, "else")
    }),

    s("req", fmt("local {} = require('{}')", { i(1), rep(1)})),

  },

  vimwiki = {
    s("qy", fmt("```yaml\n{}\n```",i(1))),
  }

},
{
  -- Give a unique key so that snippets can be reloaded via :luafile % without
  -- making extra copies of the snippet
  key = "my_snippets"
})
