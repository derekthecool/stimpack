---@meta

error('Do not require this file, for luasnip completion only')

---These Nodes contain editable text and can be jumped to- and from (e.g. traditional placeholders and tabstops, like $1 in textmate-snippets).
---@param jump_index number
---@param text string|string[]
---@param node_opts? table
function i(jump_index, text, node_opts) end

---The most simple kind of node, just text.
---@param text string|string[] The text for the node, can be an array of text
---@param node_opts? table table with more stuff
function t(text, node_opts) end

---@type fun(argnode_text: string[][], parent: table, user_args: table)
function fn_function(argnode_text, parent, user_args) end

---Function nodes insert text based on the content of other nodes using a user-defined function:
---@param fn fn_function
---@param argnode_references node_reference[]|node_reference|nil Either no, a single, or multiple node references. Changing any of these will trigger a revaluation of fn, and insertion of the updated text.
---@param node_opts? table
function f(fn, argnode_references, node_opts) end
