---@diagnostic disable: undefined-global

local treesitter_postfix = require('luasnip.extras.treesitter_postfix').treesitter_postfix

local snippets = {

    treesitter_postfix({
        trig = '.mv',
        matchTSNode = {

            query = [[
                [
                  (call_expression)
                  (identifier)
                  (template_function)
                  (subscript_expression)
                  (field_expression)
                  (user_defined_literal)
                ] @prefix
            ]],
            query_lang = 'cpp',
        },
    }, {
        f(function(_, parent)
            local node_content = table.concat(parent.snippet.env.LS_TSMATCH, '\n')
            local replaced_content = ('std::move(%s)'):format(node_content)
            return vim.split(ret_str, '\n', { trimempty = false })
        end),
    }),

    ms(
        {
            { trig = 'REGMATCH', snippetType = 'autosnippet', condition = nil },
        },
        fmt(
            [[
    #include <regex>

    std::regex word_regex("{Pattern}");
    std::smatch match;
    if (std::regex_search({input_text}, match, word_regex))
    {{
        std::cout << "First match: " << match.str() << std::endl;
    }}
    ]],
            {
                Pattern = i(1, '.*'),
                input_text = i(2, '"Input text"'),
            }
        )
    ),

    ms(
        {
            { trig = 'REGREPLACE', snippetType = 'autosnippet', condition = nil },
        },
        fmt(
            [[
        std::regex {RegexVariable}("{Pattern}");
        std::string replaced_text = std::regex_replace({InputText}, word_regex, "{ReplaceWith}");
        std::cout << "Replaced text: " << replaced_text << std::endl;
        ]],
            {
                RegexVariable = i(1, 'regex_pattern'),
                Pattern = i(2, '.*'),
                InputText = i(3, '"InputText"'),
                ReplaceWith = i(4, 'New text'),
            }
        )
    ),
}

local autosnippets = {}

return snippets, autosnippets
