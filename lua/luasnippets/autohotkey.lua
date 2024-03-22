---@diagnostic disable: undefined-global
local snippets = {
    ms(
        {
            { trig = 'FIRST', snippetType = 'autosnippet', condition = conds.line_begin },
            { trig = 'starter', snippetType = 'snippet', condition = conds.line_begin },
        },
        fmt(
            [[
        #NoEnv                ;Avoids checking empty variables to see if they are environment variables
        #SingleInstance force ;When script is run again it will not show dialog box and will replace with new code
        #InstallKeybdHook

        ; ; Use this if you want script to run as admin
        ; if not A_IsAdmin
        ; 	Run *RunAs "%A_ScriptFullPath%" ; (A_AhkPath is usually optional if the script has the .ahk extension.) You would typically check  first.

        ; ! = alt, # = windows, ^ = control, + = shift
        F11::Reload
        F12::ExitApp
        ]],
            {}
        )
    ),
}

local autosnippets = {}

return snippets, autosnippets
