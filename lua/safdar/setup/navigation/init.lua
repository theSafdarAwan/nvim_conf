local function plugins(install)
	local Plugins = {
		"nvim-tree-lua",
		"telescope-nvim",
		"harpoon",
		"find-extender-nvim",
	}

	for _, plugin in pairs(Plugins) do
		require("safdar.setup.navigation." .. plugin).install(install)
	end
end

return { get_plugins = plugins }
