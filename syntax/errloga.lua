vim.b.current_syntax = 'errloga'

vim.wo.conceallevel = 2

-- Set the color patterns for each type, actual colors are taken from color scheme
vim.api.nvim_set_hl(0, 'log_string', { link = 'String' })
vim.api.nvim_set_hl(0, 'log_number', { link = 'Number' })
vim.api.nvim_set_hl(0, 'log_date', { link = 'Type' })
vim.api.nvim_set_hl(0, 'log_time', { link = 'Type' })
vim.api.nvim_set_hl(0, 'log_keywords', { link = 'Directory' })
vim.api.nvim_set_hl(0, 'log_linenumber', { link = 'MoreMsg' })
vim.api.nvim_set_hl(0, 'log_tag', { link = 'Identifier' })
vim.api.nvim_set_hl(0, 'log_function', { link = 'Function' })
vim.api.nvim_set_hl(0, 'log_address', { link = 'Special' })
vim.api.nvim_set_hl(0, 'log_esp_ok', { link = 'DiffAdd' })
vim.api.nvim_set_hl(0, 'log_esp_err', { link = 'DiffDelete' })
vim.api.nvim_set_hl(0, 'log_version', { fg = '#00d700' })
vim.api.nvim_set_hl(0, 'log_commit_hash', { fg = '#a8a8a8' })

-- Severity levels get fixed bg/fg colors (not linked) so they stay readable as
-- a consistent "pill" regardless of colorscheme.
vim.api.nvim_set_hl(0, 'log_error', { bg = '#ff0000', fg = '#000000' })
vim.api.nvim_set_hl(0, 'log_info', { bg = '#5fd700', fg = '#000000' })
vim.api.nvim_set_hl(0, 'log_warn', { bg = '#eeaa11', fg = '#000000' })
vim.api.nvim_set_hl(0, 'log_verbose', { bg = '#f0f0f0', fg = '#000000' })
vim.api.nvim_set_hl(0, 'log_debug', { bg = '#3333ff', fg = '#000000' })

-- Basic regex matches
-- Anchored to line start: unanchored '\d\+:' also matched timestamp fragments
-- (e.g. the "20:" in "(20:25:25.504)") and MAC-address bytes (e.g. "40:" in
-- "BSSID=40:48:6E:E5:F7:C9"), mis-highlighting them as line numbers.
vim.fn.matchadd('log_linenumber', '^\\d\\+:')
vim.fn.matchadd('log_string', '".+\\{-}"')
vim.fn.matchadd('log_number', '0x[0-9a-fA-F]*\\|\\[<[0-9a-f]\\+>\\]\\|\\<\\d[0-9a-fA-F]*')
vim.fn.matchadd('log_date', '\\(Jan\\|Feb\\|Mar\\|Apr\\|May\\|Jun\\|Jul\\|Aug\\|Sep\\|Oct\\|Nov\\|Dec\\) [ 0-9]\\d *')
vim.fn.matchadd('log_date', '\\d\\{4}-\\d\\d-\\d\\d')
-- The trailing "\s-\d+:\d+" offset never appears in errloga.txt timestamps
-- (they're plain "(HH:MM:SS.mmm)"), so it's made optional rather than required.
vim.fn.matchadd('log_time', '\\d\\d:\\d\\d:\\d\\d\\.\\d\\{3}\\(\\s-\\d\\+:\\d\\+\\)\\?')

-- Section custom to errloga.txt
-- Example log:
-- 751: 2025-05-21 E (22:15:22.684) transport_base: Failed to open a new connection: 32772
-- Level letter is matched only when immediately followed by " (HH:MM:SS",
-- i.e. the actual "DATE LEVEL (TIME)" structure, instead of any lone
-- " E "/" I "/etc. substring that could appear inside a message.
vim.fn.matchadd('log_error', '\\CE\\ze (\\d\\d:\\d\\d:\\d\\d')
vim.fn.matchadd('log_info', '\\CI\\ze (\\d\\d:\\d\\d:\\d\\d')
vim.fn.matchadd('log_verbose', '\\CV\\ze (\\d\\d:\\d\\d:\\d\\d')
vim.fn.matchadd('log_warn', '\\CW\\ze (\\d\\d:\\d\\d:\\d\\d')
vim.fn.matchadd('log_debug', '\\CD\\ze (\\d\\d:\\d\\d:\\d\\d')

-- Module tag (e.g. "mqtt_service:", "LEDService:") and the "[FunctionName]"
-- context marker that follows it. Generic by design so new subsystems/
-- functions light up automatically instead of needing a new literal entry
-- in the keyword list below every time firmware logging changes.
vim.fn.matchadd('log_tag', '\\d\\d:\\d\\d:\\d\\d\\.\\d\\{3})\\s\\+\\zs[A-Za-z_][A-Za-z0-9_]*\\ze:')
vim.fn.matchadd('log_function', '\\[[A-Za-z_][A-Za-z0-9_ ]*\\]')

-- MAC addresses (WiFi scan BSSIDs) and IPv4 addresses (PPP/VPN endpoints).
vim.fn.matchadd('log_address', '\\x\\x:\\x\\x:\\x\\x:\\x\\x:\\x\\x:\\x\\x')
vim.fn.matchadd('log_address', '\\<\\d\\{1,3}\\.\\d\\{1,3}\\.\\d\\{1,3}\\.\\d\\{1,3}\\>')

-- ESP-IDF status codes, recognizable regardless of which subsystem logs them.
vim.fn.matchadd('log_esp_ok', '\\<ESP_OK\\>')
vim.fn.matchadd('log_esp_err', '\\<ESP_\\(ERR_[A-Za-z_]\\+\\|FAIL\\)\\>')

-- Boolean/enabled-disabled state words, same good/bad coloring as ESP codes.
vim.fn.matchadd('log_esp_ok', '\\<\\(true\\|Enable\\|ENABLED\\)\\>')
vim.fn.matchadd('log_esp_err', '\\<\\(false\\|Disable\\|DISABLED\\)\\>')

-- Firmware version string, e.g. "v26.3.4-3-g49018b94": version number in
-- green, the 8-char commit hash after "g" in light gray. The "-3-" build/
-- distance segment in between isn't meaningful, so it's left unhighlighted.
vim.fn.matchadd('log_version', 'v\\d\\+\\.\\d\\+\\.\\d\\+\\ze-\\d\\+-g\\x\\{8}\\>')
vim.fn.matchadd('log_commit_hash', 'v\\d\\+\\.\\d\\+\\.\\d\\+-\\d\\+-g\\zs\\x\\{8}\\ze')

-- Keywords confirmed against current firmware output; prune/extend as the
-- actual log text changes rather than carrying forward strings from past
-- devices/firmware that no longer appear anywhere.
vim.fn.matchadd('log_keywords', '\\*\\*\\*.*\\*\\*\\*')
vim.fn.matchadd('log_keywords', 'Set Current Mode to')
-- syntax region  geofenceNoReport start=/^geo/ end=/$/ skip=/\\./
-- syntax region  geofenceReport start=/^geo. --false/ end=/$/ skip=/\\./
