-- Inspiration from this link
-- https://github.com/sid-6581/NeovimConfig/blob/cb4c1f675d823250f2264a955b56c30221cc51c3/lua/plugins/lsp/handlers.lua#L133-L151
-- https://github.com/PowerShell/PSScriptAnalyzer/blob/e1dc126c361398d6ead6556c24c544702b1918cb/Engine/Settings/CodeFormattingStroustrup.psd1#L4
-- https://github.com/SergeCaron/Create_USB_Drive_for_Windows_Installation/blob/961678c1b819590952634626320e58c7d5b730fb/FormattingRules.psd1#L4
return {
    settings = {
        powershell = {
            scriptAnalysis = {
                -- settingsPath = string.format('%s/lua/stimpack/lsp/PowershellOptions.psd1', OS.nvim),
                settingsPath = string.format('%s/PSScriptAnalyzerSettings.psd1', OS.home),
                -- Feb 2025 update: moved this psd1 file from stimpack repository to MyCrossPlatformDotfiles
            },
            codeFormatting = {
                autoCorrectAliases = true,

                -- All of these settings have been moved into the PowershellOptions.psd1 file
                -- avoidSemicolonsAsLineTerminators = true,
                -- preset = 'Allman',
                -- trimWhitespaceAroundPipe = true,
                -- useConstantStrings = true,
                -- useCorrectCasing = true,
                -- whitespaceBetweenParameters = true,
            },
        },
    },
}
