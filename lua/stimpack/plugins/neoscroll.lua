return {
    'karb94/neoscroll.nvim',
    -- keys = {'<C-d>', '<C-u>'},
    config = function()
        require('neoscroll').setup({
            hide_cursor = true, -- Hide cursor while scrolling
            stop_eof = true, -- Stop at <EOF> when scrolling downwards
            use_local_scrolloff = true, -- Use the local scope of scrolloff instead of the global scope
            respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
            cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
            easing_function = 'quadratic', -- Default easing function
            pre_hook = nil, -- Function to run before the scrolling animation starts
            post_hook = nil, -- Function to run after the scrolling animation ends
            performance_mode = false, -- Disable "Performance Mode" on all buffers.
        })

        local t = {}
        -- Syntax: t[keys] = {function, {function arguments}}
        local delay = 350
        local easing_function = nil
        local scroll_amount = 0.4
        t['<C-u>'] = { 'scroll', { scroll_amount * -1, 'true', delay, easing_function } }
        t['<C-d>'] = { 'scroll', { scroll_amount, 'true', delay, easing_function } }

        require('neoscroll.config').set_mappings(t)
    end,
}
