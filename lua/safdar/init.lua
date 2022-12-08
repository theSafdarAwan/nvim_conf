local M = {}

M.default = function()
	require("safdar.core").core()
end

M.plugins = function()
	require("safdar.plugins")
	require("safdar.core").plugins()
	require("safdar.core.lazy_load")
end

return M
