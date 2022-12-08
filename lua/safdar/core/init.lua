local M = {}

M.core = function()
	require("safdar.core.options")
	require("safdar.core.autocmds").autocmds()
	require("safdar.core.mappings")
end

M.plugins = function()
	require("safdar.core.autocmds").plugins_autocmds()
end

return M
