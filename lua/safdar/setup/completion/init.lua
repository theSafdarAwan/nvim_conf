local function plugins(install)
	local Plugins = {
		"nvim-cmp",
		"luasnip",
		"cmp-tabnine",
		"nvim-cmp-dictionary",
		"nvim-autopairs",
	}

	for _, plugin in pairs(Plugins) do
		require("safdar.setup.completion." .. plugin).install(install)
	end
end

return { get_plugins = plugins }
