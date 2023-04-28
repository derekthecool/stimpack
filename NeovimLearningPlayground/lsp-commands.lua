-- TODO: find a way to check how many references to a function to variable are found. I want to copy visual Studio feature
local dog = 4
dog = 7
dog = false

-- This is here so I can prove I'm getting the right line for later
local fancyParams = vim.lsp.util.make_position_params(0)
print(fancyParams)

local opts = {
    winnr = vim.api.nvim_get_current_win(),
    include_current_line = true,
    include_declaration = true,
    bufnr = vim.api.nvim_get_current_buf(),
    line_number = 2, -- used to filter out current line if desired
    reference_line_number = 1,
    reference_column_number = 6,
}

print(opts)

get_references = function(opts)
    local filepath = vim.api.nvim_buf_get_name(opts.bufnr)
    print(filepath)
    -- local filepath = vim.api.nvim_buf_get_name(lsp.referencesopts.bufnr)

    -- local lnum = vim.api.nvim_win_get_cursor(opts.winnr)[1]
    local lnum = opts.line_number
    print(lnum)

    -- This gets current cursor position, not good for stationery testing proof of concept
    -- Uses 0 based line and column numbers
    local fancyParams = vim.lsp.util.make_position_params(opts.winnr)
    print(fancyParams)
    local params = {
        position = {
            character = opts.reference_column_number,
            line = opts.reference_line_number,
        },
        textDocument = {
            uri = 'file:///C:/Users/dlomax/AppData/Local/nvim/NeovimLearningPlayground/lsp-commands.lua',
        },
    }
    print(params)
    local include_current_line = vim.F.if_nil(opts.include_current_line, false)
    params.context = { includeDeclaration = vim.F.if_nil(opts.include_declaration, true) }

    return vim.lsp.buf_request(opts.bufnr, 'textDocument/references', params, function(err, result, ctx, final)
        -- Error details if not nil
        print(err)
        -- LSP search results
        print(result)
        -- Context
        print(ctx)
        -- Not sure what this one is
        print(final)
        if err then
            vim.api.nvim_err_writeln('Error when finding references: ' .. err.message)
            return
        end

        local locations = {}

        if result then
            local results =
                vim.lsp.util.locations_to_items(result, vim.lsp.get_client_by_id(ctx.client_id).offset_encoding)
            print(results)

            if not include_current_line then
                locations = vim.tbl_filter(function(v)
                    print(v)
                    -- Remove current line from result
                    return not (v.filename == filepath and v.lnum == lnum)
                end, vim.F.if_nil(results, {}))
            else
                locations = vim.F.if_nil(results, {})
            end
        end

        -- TODO: print extmarks at declaration of functions to show reference count
        print(locations)
        print(#locations)
        return locations
    end)
end

local output, cancelFunction = get_references(opts)
print(output)
print(cancelFunction)
