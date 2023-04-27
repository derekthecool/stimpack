---@meta

--[[
This link shows lots and lots of information about all the classes
https://wiki.wireshark.org/uploads/04a18cffc1ba39292e97a99252d93416/220711_wslua_Index_DRAFT.pdf
]]

error('Do not require this file, for wireshark completion only')

---@type versionTable { version: string, author: string, description: string, repository: string }

---Add information about this plugin
---@param stuff versionTable
function set_plugin_info(stuff) end

---@class Proto
Proto = {}

---Create a new protocol
---@param name The name of the protocol
---@param description The description of the protocol
Proto.new = function(name, description) end

---Awesome function
---https://wiki.wireshark.org/Lua/Examples
--- 8 -- the dissector function callback
--- 9 function myproto.dissector(tvb,pinfo,tree)
--- 10     pinfo.cols.info:append(" " .. tostring(pinfo.dst).." -> "..tostring(pinfo.src))
--- 11 end
---@param tvb userdata The buffer to dissect. A Tvb represents the packet's buffer. It is passed as an argument to listeners and dissectors, and can be used to extract information (via TvbRange) from the packet's data. Beware that Tvbs are usable only by the current listener or dissector call and are destroyed as soon as the listener/dissector returns, so references to them are unusable once the function has returned. To create a tvbrange the tvb must be called with offset and length as optional arguments ( the offset defaults to 0 and the length to tvb:len() )
---@param pinfo userdata The packet information
---@param tree userdata The tree on which to add the protocol items
Proto.dissector = function(tvb, pinfo, tree) end

---@class ProtoField
ProtoField = {}

---Create new fields
---@param name The name of the field
---@param description The description of the field
ProtoField.string = function(name, description) end

---@class Field
Field = {}

---@param fieldName The name of the wireshark field to search for. For example mqtt.topic or tcp.port
Field.new = function(fieldName) end
