---@diagnostic disable: undefined-global
local snippets = {
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
