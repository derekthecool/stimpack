---@diagnostic disable: undefined-global

local my_treesitter_functions = require('stimpack.my-treesitter-functions')

local snippets = {
    s(
        'starter',
        fmt(
            [[
    #!/usr/bin/env bash

    # Set safer defaults, do not proceed past unhandled errors
    set -euxo pipefail
    ]]       ,
            {}
        )
    ),
}

local autosnippets = {

    s(

        'shebang',
        fmt(
            [[
        {}
        ]]   ,
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
      ]]     ,
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
