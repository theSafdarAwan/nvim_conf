local function plugins(install)
	local plugin_list = {
		"cmp",
		"luasnip",
		"autopairs",
	}

	for _, plugin in pairs(plugin_list) do
		require("safdar.setup.completion." .. plugin).install(install)
	end
end

return { get_plugins = plugins }
