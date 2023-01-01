local function get_plugins(install)
	local plugins_list = {
		"dap",
	}

	for _, plugin in pairs(plugins_list) do
		require("safdar.setup.debugging." .. plugin).install(install)
	end
end

return { get_plugins = get_plugins }
