--- loading editor configuration
local M = {}

--- default configuration which includes editor related maps, options,
--- auto commands, etc.
M.default = function()
	require("safdar.default")
end

--- load's PDE(Personal Development Environment).
M.setup = function()
	require("safdar.setup")
	-- load the personal scripts after the plugins are loaded
	require("safdar.personal")
end

return M
