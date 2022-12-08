local M = {}

M.default = function()
	require("safdar.core").core()
end

M.plugins = function()
	require("safdar.plugins")
	require("safdar.core").plugins()
end

return M
