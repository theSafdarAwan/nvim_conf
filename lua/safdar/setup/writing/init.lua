local function plugins(install)
	local plugin_list = {
		"neorg",
		"markdown-preview",
	}

	for _, plugin in pairs(plugin_list) do
		require("safdar.setup.writing." .. plugin).install(install)
	end
end

return { get_plugins = plugins }
