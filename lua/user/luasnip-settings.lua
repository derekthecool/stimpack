--[[
Guide to creating snippets

Use the locals at the top of this file for shorter writing
for example you can define a snippet with "s" because of this line at the top
local s = ls.snippet

Escape characters:
$ --> $$
Quotes are tough, but the following should work:
" --> \"
"word"..'"'.."text wrapped in quotes"..'"'
-- For use in fmt
{ --> {{
} --> }}



Examples: Use captures from the regex-trigger using a functionNode:

>
    s({trig = "b(%d)", regTrig = true},
        f(function(args, snip) return
            "Captured Text: " .. snip.captures[1] .. "." end, {})
    )
]]
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

ls.add_snippets(nil, {
  all = {

  },

  lua = {
    s("ternary", {
        i(1, "cond"), t(" ? "), i(2, "then"), t(" : "), i(3, "else")
    }),

    s("req", fmt("local {} = require('{}')", { i(1), rep(1)})),

  },

  vimwiki = {
    s("qy", fmt("```yaml\n{}\n```",i(1))),

    -- s("mermaid-Flowchart", fmt("```mermaid\ngraph\n\nA[Start] --> B{{Do a thing}}\nB -- Yes --> C[OK]\nB -- No --> D[Bad]\nC --> E[End]\nD --> E[End]\n{}```"), i(0)),
  },

  cs = {
    -- Awesome Console.WriteLine with $ for variable expansion
    -- s("cw", fmt("Console.WriteLine($\"{}\");"), i(1)),
    s({
      trig = "cw",
      name = "Console.WriteLine",
      dscr = "My very, very cool snippet",
    },
    fmt("Console.WriteLine($"..'"'.."{}"..'"'..");", i(1))
    ),

    s("file", t("// The file name is $TM_FILENAME")),

    -- Process that reads from stdout in a bocking manner

    -- s("process", fmt(
    -- [[
    -- var {} = new Process
    --  {{
    --    StartInfo = new ProcessStartInfo
    --   {{
    --       FileName = {},
    --       UseShellExecute = false,
    --       RedirectStandardOutput = true,
    --       CreateNoWindow = true
    --   }}
    --  }};
    --
    --   process.Start(());
    --   while ((process.StandardOutput.EndOfStream == false))
    --   {{
    --
    --   }}
    --  ]], i(1), rep(1)
    -- ))
  }

},
{
  -- Give a unique key so that snippets can be reloaded via :luafile % without
  -- making extra copies of the snippet
  key = "my_snippets"
})
