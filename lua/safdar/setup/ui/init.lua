local function plugins(install)
	local Plugins = {
		"fused",
		"feline",
		"nvim-web-devicons",
		"nvim-treesitter",
		"playground",
		"nvim-colorizer-lua",
		"vim-illuminate",
		"indent-blankline-nvim",
		"noice-nvim",
		"dressing-nvim",
	}

	local temp_plugins = {
		"monokai-pro",
		"themes",
	}
	for _, plugin in ipairs(temp_plugins) do
		table.insert(Plugins, plugin)
	end

	for _, plugin in pairs(Plugins) do
		require("safdar.setup.ui." .. plugin).install(install)
	end
end

return { get_plugins = plugins }
