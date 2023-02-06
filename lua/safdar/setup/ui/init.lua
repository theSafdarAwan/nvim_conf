local function plugins(install)
	local plugin_list = {
		"fused",
		"feline",
		"devicons",
		"treesitter",
		"ts-playground",
		"colorizer",
		"themes",
		"vim-illuminate",
		"indent-blank-line",
	}

	for _, plugin in pairs(plugin_list) do
		require("safdar.setup.ui." .. plugin).install(install)
	end
end

return { get_plugins = plugins }
