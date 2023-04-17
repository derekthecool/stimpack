-- Inspiration from this link
-- https://github.com/sid-6581/NeovimConfig/blob/cb4c1f675d823250f2264a955b56c30221cc51c3/lua/plugins/lsp/handlers.lua#L133-L151
return {
    settings = {
        powershell = {
            codeFormatting = {
                autoCorrectAliases = true,
                avoidSemicolonsAsLineTerminators = true,
                preset = 'OTBS',
                trimWhitespaceAroundPipe = true,
                useConstantStrings = true,
                useCorrectCasing = true,
                whitespaceBetweenParameters = true,
            },
        },
    },
}
