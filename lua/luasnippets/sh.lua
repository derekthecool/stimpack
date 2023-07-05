---@diagnostic disable: undefined-global

local my_treesitter_functions = require('stimpack.my-treesitter-functions')

local snippets = {
    -- Help with the PS4 function here: https://stackoverflow.com/a/17805088/9842112
    s(
        'starter',
        fmt(
            [[
    #!/usr/bin/env bash

    # Set safer defaults, do not proceed past unhandled errors
    set -euxo pipefail

    # Easily debug the script with this special PS4 prompt
    PS4='+(${{BASH_SOURCE}}:${{LINENO}}): ${{FUNCNAME[0]:+${{FUNCNAME[0]}}(): }}'
    ]],
            {}
        )
    ),

    s(
        'trap',
        fmt(
            [[
        {} ()
        {{
            {}
        }}

        # Run the function: {} upon script exit (includes control-c press)
        trap {} EXIT
        ]],
            {
                i(1, 'run_before_shutdown'),
                i(2, 'echo "Hello World"'),
                rep(1),
                rep(1),
            }
        )
    ),

    s(
        'tcpdump',
        fmt([[tcpdump -i any {} -w "$filename" -v]], {
            c(1, {
                t('port 5000'),
                t('portrange 5000-6000'),
            }),
        })
    ),
}

local autosnippets = {

    s(
        'IF',
        fmt(
            [=[
        if [[ {} ]]; then
            {}
        fi
        ]=],
            {
                i(1, '10 -gt 5'),
                i(2),
            }
        )
    ),

    s(
        'PRINT',
        fmt(
            [[
        {}
        ]],
            {
                c(1, {
                    sn(
                        nil,
                        fmt(
                            [[
               echo "{}"
               ]],
                            {
                                i(1),
                            }
                        )
                    ),

                    sn(
                        nil,
                        fmt(
                            [[
               printf "{}\n" {}
               ]],
                            {
                                i(1, 'Hello world'),
                                i(2, 'Variables'),
                            }
                        )
                    ),
                }),
            }
        )
    ),

    s(
        '$$',
        fmt(
            [[
        ${{{}}}
        ]],
            {
                d(1, function()
                    local snippet_table = {}

                    -- Load table with nodes here
                    local variables = require('stimpack.my-treesitter-functions').bash.get_all_variables_in_file()
                    if variables ~= nil then
                        for _, value in pairs(variables) do
                            local text_node = t(value)
                            table.insert(snippet_table, text_node)
                        end
                    else
                        table.insert(snippet_table, t('no_variables_found'))
                    end

                    return sn(
                        nil,
                        fmt(
                            [[
                            {}
                            ]],
                            {
                                c(1, snippet_table),
                            }
                        )
                    )
                end, {}),
            }
        )
    ),

    s(
        'FUNCTION',
        fmt(
            [[
        {} ()
        {{
            {}
        }}
        ]],
            {
                i(1, 'MyFunction'),
                i(2, 'echo "Hello World"'),
            }
        )
    ),

    s(
        'WHILE',
        fmt(
            [[
        while {} {} {}; do
            {}
        done
        ]],
            {
                t('[['),
                i(1),
                t(']]'),
                i(2),
            }
        )
    ),

    s(

        'shebang',
        fmt(
            [[
        {}
        ]],
            {
                c(1, {
                    t('#!/usr/bin/env bash'),
                    t('#!/usr/bin/env sh'),
                    t('#!/bin/bash'),
                    t('#!/bin/sh'),
                }),
            }
        )
    ),

    s(
        'var var',
        fmt(
            [[
      {}
      ]],
            {
                f(function()
                    local variable = my_treesitter_functions.bash.get_recent_var()
                    return variable
                end, {}),
            }
        )
    ),
}

return snippets, autosnippets

-- snippet getopts-good "Slightly altered getops than the default" b
-- ScriptVersion="${1:Version}"
--
-- #===  FUNCTION  ================================================================
-- #         NAME:  usage
-- #  DESCRIPTION:  Display usage information.
-- #===============================================================================
-- function usage ()
-- {
--   echo "Usage :  $0 [options] [--]
--
--     Options:
--     -${2:Short}|${3:Long}    ${4:Option Description}
--     -h|help       Display this message
--     -v|version    Display script version"
--
-- }    # ----------  end of function usage  ----------
--
-- #-----------------------------------------------------------------------
-- #  Handle command line arguments
-- #-----------------------------------------------------------------------
--
-- while getopts ":hv" opt
-- do
--   case "$\{opt\}" in
--
--   ${2}|${3}      )  ${5:Functionality}   ;;
--
--   h|help     )  usage; exit 0   ;;
--
--   v|version  )  echo "$0 -- Version $ScriptVersion"; exit 0   ;;
--
--   * )  echo -e "\n  Option does not exist : OPTARG\n"
--         usage; exit 1   ;;
--
--   esac    # --- end of case ---
-- done
-- shift $((OPTIND-1))
-- endsnippet
--
-- snippet Header "Header Information For Bash Script" b
-- # Author:
-- # ${1:Derek Lomax}
--
-- # Dependencies:
-- # ${2:grep,fzf}
--
-- # Script Purpose:
-- # ${3}
-- endsnippet
--
-- snippet sheb "Add a shebang" bA
-- #!/bin/bash
-- endsnippet
--
-- snippet __ "Write a variable with quotes" A
-- "$${1:Variable}"
-- endsnippet
--
-- snippet cprint-color-print-function "Derek's awesome color print function" b
-- cprint() {
--
--   # Define constants for the color code variables
--   # BG is always +10 from FG
--   defaultForeground=39 ; defaultBackground=\$((\$defaultForeground+10))
--   blackForeground=30   ; blackBackground=\$((\$blackForeground+10))
--   redForeground=31     ; redBackground=\$((\$redForeground+10))
--   greenForeground=32   ; greenBackground=\$((\$greenForeground+10))
--   yellowForeground=33  ; yellowBackground=\$((\$yellowForeground+10))
--   blueForeground=34    ; blueBackground=\$((\$blueForeground+10))
--
--   parseFG() {
--     case \$1 in
--       black) foreground=\$blackForeground ;;
--       red) foreground=\$redForeground ;;
--       green) foreground=\$greenForeground ;;
--       yellow) foreground=\$yellowForeground ;;
--       blue) foreground=\$blueForeground ;;
--       *) foreground=\$defaultForeground ;;
--     esac
--   }
--
--   parseBG() {
--     case \$1 in
--       black) background=\$blackBackground ;;
--       red) background=\$redBackground ;;
--       green) background=\$greenBackground ;;
--       yellow) background=\$yellowBackground ;;
--       blue) background=\$blueBackground ;;
--       *) background=\$defaultBackground ;;
--     esac
--   }
--
--   # We need at least one argument to print
--   case \$# in
--     1)
--       foreground=\$defaultForeground
--       background=\$defaultBackground
--       ;;
--     2)
--       parseFG \$2
--       background=\$defaultBackground
--       ;;
--     3)
--       parseFG \$2
--       parseBG \$3
--       ;;
--     *)
--       printf "Invalid printc usage, called with \$# arguments"
--       return 1
--   esac
--
--   # Print the message with the desired text and then clear the formatting
--   coloredText="\033[\${foreground};\${background}m"
--   normalText="\033[0m"
--   printf "\${coloredText}\$1\${normalText}\n"
-- }
-- endsnippet
