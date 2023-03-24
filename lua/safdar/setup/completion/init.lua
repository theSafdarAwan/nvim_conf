--- This Plugins Module includes plugins related to completion and snippets.

---@table Plugins
---@field nvim_cmp Plugin completion engine.
---@field luasnip Plugin snippets generator.
---@field cmp_tabnine Plugin tabnine AI code completion.
---@field nvim_cmp_dictionary Plugin dictionary plugin for cmp.
---@field nvim_autopairs Plugin autopair {['" and other punctuations.

local function plugins(install)
	local plugin_list = {
		"nvim-cmp",
		"luasnip",
		"cmp-tabnine",
		"nvim-cmp-dictionary",
		"nvim-autopairs",
	}

	for _, plugin in pairs(plugin_list) do
		require("safdar.setup.completion." .. plugin).install(install)
	end
end

return { get_plugins = plugins }
