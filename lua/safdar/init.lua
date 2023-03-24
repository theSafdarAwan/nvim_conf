--- This is my personal setup for these programming languages.
--- [html, css, javascript, typescript, lua, c, rust, python, golang, viml, fennel, bash, json]

local M = {}

--- default configuration which includes editor related maps, options,
--- auto commands, etc.
M.default = function()
	require("safdar.default")
end

--- this setup function is main function for adding plugins
M.setup = function()
	require("safdar.setup")
end

return M
