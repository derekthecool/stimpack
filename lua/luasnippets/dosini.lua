---@diagnostic disable: undefined-global
local snippets = {}

local autosnippets = {
    s(
        'FIRST',
        fmt(
            [[
         [project-build]

         # shell command, use quotation for filenames containing spaces
         # check ":AsyncTaskMacro" to see available macros
         # command=gcc "$(VIM_FILEPATH)" -o "$(VIM_FILEDIR)/$(VIM_FILENOEXT)"

         # working directory, can change to $(VIM_ROOT) for project root
         cwd=$(VIM_FILEDIR)

         # output mode, can be one of quickfix and terminal
         # - quickfix: output to quickfix window
         # - terminal: run the command in the internal terminal
         output=quickfix

         # this is for output=quickfix only
         # if it is omitted, vim's current errorformat will be used.
         errorformat=%f:%l:%m

         # save file before execute
         save=1

         [project-run]
         command="$(VIM_FILEDIR)/$(VIM_FILENOEXT)"
         cwd=$(VIM_FILEDIR)
         # output mode: run in a terminal
         output=terminal
         ]],
            {}
        )
    ),
}

return snippets, autosnippets
