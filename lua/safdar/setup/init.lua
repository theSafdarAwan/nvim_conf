--- setup function adds plugins to the stack
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
		"debugging",
		"writing",
	}
	for _, mod in pairs(modules) do
		require("safdar.setup." .. mod).get_plugins(install)
	end
	return plugins
end

require("safdar.setup.bootstrap").bootstrap(setup)
