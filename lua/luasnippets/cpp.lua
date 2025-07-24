---@diagnostic disable: undefined-global

local treesitter_postfix = require('luasnip.extras.treesitter_postfix').treesitter_postfix

local function lambda(index)
    return sn(
        index,
        fmt([[{Format}]], {
            Format = c(1, {
                sn(
                    nil,
                    fmt([=[[{Captures}]({Variables}){{ return {Code} }}]=], {
                        Captures = r(1, ''),
                        Variables = r(2, 'int x'),
                        Code = i(3, 'x * x'),
                    })
                ),

                sn(
                    nil,
                    fmt(
                        [=[
                        [{Captures}]({Variables})
                        {{
                            return {Code}
                        }}
                        ]=],
                        {
                            Captures = r(1, ''),
                            Variables = r(2, 'int x'),
                            Code = i(3, 'x * x'),
                        }
                    )
                ),
            }),
        })
    )
end

local snippets = {

    ms({
        { trig = 'map', snippetType = 'snippet', condition = nil },
        { trig = 'map map', snippetType = 'autosnippet', condition = nil },
    }, fmt([[std::views::transform({lambda_function})]], { lambda_function = lambda(1) })),

    ms(
        {
            { trig = 'filter', snippetType = 'snippet', condition = nil },
            { trig = 'filter filter', snippetType = 'autosnippet', condition = nil },
        },
        fmt([[std::views::filter({lambda_function})]], {
            lambda_function = lambda(1),
        })
    ),

    ms(
        {
            { trig = 'fold', snippetType = 'snippet', condition = nil },
            { trig = 'fold fold', snippetType = 'autosnippet', condition = nil },
            { trig = 'reduce', snippetType = 'snippet', condition = nil },
            { trig = 'reduce reduce', snippetType = 'autosnippet', condition = nil },
        },
        fmt([[std::accumulate({start}, {end_value}, {initial_value})]], {
            start = i(1, 'numbers.start()'),
            end_value = i(2, 'numbers.end()'),
            initial_value = i(3, '0'),
        })
    ),

    ms(
        {
            { trig = 'range', snippetType = 'snippet', condition = nil },
            { trig = 'range range', snippetType = 'autosnippet', condition = nil },
        },
        fmt(
            [[
        std::views::iota({start}, {stop})
        ]],
            {
                start = i(1, '1'),
                stop = i(2, '10'),
            }
        )
    ),

    ms(
        {
            { trig = 'uppercase', snippetType = 'snippet', condition = nil },
        },
        fmt([[transform({value}.begin(), {value_rep}.end(), {value_rep}.begin(), ::toupper)]], {
            value = i(1, 'string_name'),
            value_rep = rep(1),
        })
    ),

    ms({
        { trig = 'LAMBDA', snippetType = 'autosnippet', condition = nil },
    }, { lambda(1) }),

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

    ms(
        {
            { trig = 'FREACH', snippetType = 'autosnippet', condition = conds.line_begin },
        },
        fmt(
            [[
        for (const auto &{item} : {source}) {{
            cout << command << endl;
        }}
        ]],
            {
                item = i(1, 'item'),
                source = i(2, 'source_vector'),
            }
        )
    ),
}

local autosnippets = {}

return snippets, autosnippets
