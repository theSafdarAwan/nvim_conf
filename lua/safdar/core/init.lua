local M = {}

M.core = function()
	-- to est the deprecations
	require("safdar.core.utils").deprecated()

	require("safdar.core.options")
	require("safdar.core.autocmds").autocmds()
	require("safdar.core.mappings")
end

M.plugins = function()
	require("safdar.core.autocmds").plugins_autocmds()
end

return M
