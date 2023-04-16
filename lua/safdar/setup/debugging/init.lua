local function get_plugins(install)
	local Plugins = {
		"nvim-dap",
	}

	for _, plugin in pairs(Plugins) do
		require("safdar.setup.debugging." .. plugin).install(install)
	end
end

return { get_plugins = get_plugins }
