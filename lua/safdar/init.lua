--- loading editor configuration
local M = {}

--- default configuration which includes editor related maps, options,
--- auto commands, etc.
M.default = function()
	require("safdar.default")
end

--- main function for adding plugins
M.setup = function()
	require("safdar.setup")
end

return M
