--- loading editor configuration
local M = {}

--- default configuration which includes editor related maps, options,
--- auto commands, etc.
M.default = function()
	require("safdar.default")
end

--- load PDE(Personal Development Environment).
M.setup = function()
	require("safdar.setup")
end

return M
