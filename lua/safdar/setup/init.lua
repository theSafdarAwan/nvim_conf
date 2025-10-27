--- Loads plugins modules using lazy.nvim

--- Requires plugins modules.
---@return table plugins.
local function setup()
	local plugins = {}
	local function install(plugin)
		table.insert(plugins, plugin)
	end
	local modules = {
		"core",
		"ui",
		"navigation",
		"git",
		"lsp",
		"completion",
		"others",
		-- "debugging",
		"writing",
	}
	for _, module in pairs(modules) do
		require("safdar.setup." .. module).get_plugins(install)
	end

	return plugins
end
require("safdar.setup.bootstrap").bootstrap(setup)
