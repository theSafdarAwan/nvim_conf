local plugins = function(install)
	local plugin_list = {
		"vim-matchup",
		"undotree",
		"comment",
		"todo-comments",
		"comment-frame",
		"surround",
		"refactoring",
		"vim-be-good",
		"nvim-spectre",
		----------------------------------------------------------------------
		--                        Window Management                         --
		----------------------------------------------------------------------
		"nvim-window-picker",
		"winshift",
		"focus",
	}

	for _, plugin in pairs(plugin_list) do
		require("safdar.setup.others." .. plugin).install(install)
	end
end

return { get_plugins = plugins }
