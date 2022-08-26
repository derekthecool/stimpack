---@diagnostic disable: undefined-global

local my_treesitter_functions = require('stimpack.my-treesitter-functions')

-- --lua treesitter functions
-- local function get_recent_var()
--   local get_root = function(bufnr)
--     local parser = vim.treesitter.get_parser(bufnr, 'lua', {})
--     local tree = parser:parse()[1]
--     return tree:root()
--   end
--
--   local my_query = vim.treesitter.parse_query('lua', '(variable_list) @variable')
--   local bufnr = vim.api.nvim_get_current_buf()
--   local root = get_root(bufnr)
--
--   local current_row = vim.api.nvim_win_get_cursor(0)
--   print(current_row)
--   local closest_row_above = 1000
--   local variable_name = ''
--   for id, node in my_query:iter_captures(root, bufnr, 0, -1) do
--     local _, _, row, _ = node:range()
--     if row < current_row[1] then
--       closest_row_above = row
--       variable_name = vim.treesitter.get_node_text(node, bufnr)
--       print(variable_name)
--     end
--   end
--
--   print(closest_row_above)
--   return variable_name
-- end
--
--

local snippets = {

  -- {{{ Snippets to help create luasnip snippets
  s(
    {
      trig = 'snippet file',
      descr = 'Basic start for a snippet file named [ft].lua and located in the snippets directory of my neovim config',
    },

    fmt(
      [[
      ---@diagnostic disable: undefined-global
      local snippets = {{
          {}
      }}

      local autosnippets = {{
          {}
      }}

      return snippets, autosnippets
      ]],
      { i(1), i(2) }
    )
  ),

  -- }}}

  -- {{{ Neovim command and API snippets

  -- }}}
}

local autosnippets = {

  -- {{{ Neovim command and API snippets
  s('VIM.NOTIFY', fmt([[vim.notify({})]], { i(1, 'Notify text') })),
  -- }}}

  -- {{{ Fast steno commands to trigger snippets
  s(
    'IF',
    fmt(
      [[
    if {} then
       {}
    end]],
      {
        i(1),
        i(2),
      }
    )
  ),

  s(
    'PRINT',
    fmt(
      [[
      print({})
      {}
      ]],
      { i(1), i(0) }
    )
  ),

  s(
    { trig = 'DESCRIBE', descr = 'Plenary test group' },
    fmt(
      [[
        describe('{}', function()
          it('{}', function()
              {}
          end)
        end)
    ]] ,
      {
        i(1, 'Test group name '),
        i(2, 'Test name'),
        i(3),
      }
    )
  ),

  s(
    { trig = 'TEST', descr = 'Single Plenary test' },
    fmt(
      [[
        it('{}', function()
            {}
        end),
    ]] ,
      {
        i(1, 'Test name'),
        i(2),
      }
    )
  ),

  -- }}}

  -- Luasnip functions

  s(
    {
      trig = 'snip snip',
      descr = 'New luasnip snippet starter',
    },
    fmt(
      [=[
      s(
        {},
        fmt(
          [[
          {}
          ]],
          {{
            {}
          }}
        )
      ),
      {}
      ]=],

      {
        c(1, {
          i(1, '\'short snippet trigger\''),
          sn(
            1,
            fmt(
              [[
              {{
                trig = '{}',
                regTrig = {},
                descr = '{}',
              }}
              ]],
              {
                i(1, 'long snippet trigger'),
                c(2, {
                  t('true'),
                  t('false'),
                }),
                i(3, 'description'),
              }
            )
          ),
        }),
        i(2),
        i(3),
        i(0),
      }
    )
  ),

  s(
    {
      trig = 'long snippet trigger',
      regTrig = true,
      descr = 'description',
    },
    fmt(
      [[
      {}
      ]],
      {
        t('text'),
      }
    )
  ),

  s(
    {
      trig = 'text node',
      descr = 'insert a text node',
    },
    fmt(
      [[
      t('{}'),
      {}
      ]],
      {
        i(1, 'text'),
        i(0),
      }
    )
  ),

  s(
    {
      trig = 'insert node',
      descr = 'insert a new insert node',
    },
    fmt(
      [[
      i({}, '{}'),
      {}
      ]],
      {
        i(1, '1'),
        i(2, 'default'),
        i(0),
      }
    )
  ),

  -- Needs work
  s(
    {
      trig = 'function node',
      descr = 'insert a function node',
    },
    fmt(
      [[
      f(function(args, snip)
        {}
      end,
      {{ {} }}),
      {}
      ]],
      {
        i(1),
        i(2, 'node_number'),
        i(0),
      }
    )
  ),

  s(
    {
      trig = 'choice node',
      descr = 'insert a choice node',
    },
    fmt(
      [[
      c({},
      {{
        {}
      }}),
      {}
      ]],
      {
        i(1, 'node number'),
        i(2, [[t('new text'),]]),
        i(0),
      }
    )
  ),

  s('trig', {
    t('text: '),
    i(1),
    t({ '', 'copy: ' }),
    d(2, function(args)
      -- the returned snippetNode doesn't need a position; it's inserted
      -- "inside" the dynamicNode.
      return sn(nil, {
        -- jump-indices are local to each snippetNode, so restart at 1.
        i(1, args[1]),
      })
    end, { 1 }),
  }),

  -- add dynamic node
  s(
    'dynamic node',
    fmt(
      [[
      d({}, function(args)
        return sn(nil,{{
          {}
        }}) end,
        {{ {} }}
       )
       {}
      ]],
      {
        i(1, '1'),
        i(2),
        i(3, '1'),
        i(0),
      }
    )
  ),

  -- end lua snip functions

  s(
    'var var',
    fmt(
      [[
      {}
      ]],
      {
        f(function()
          return my_treesitter_functions.lua.get_recent_var()
        end, {}),
      }
    )
  ),

  -- add restore node
}

return snippets, autosnippets
