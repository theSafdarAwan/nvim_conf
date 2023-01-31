local function plugins(install)
	local plugin_list = {
		"nvim-tree",
		"telescope",
		"harpoon",
		"find-extender"
	}

	for _, plugin in pairs(plugin_list) do
		require("safdar.setup.navigation." .. plugin).install(install)
	end
end

return { get_plugins = plugins }
