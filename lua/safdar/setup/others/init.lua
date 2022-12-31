local plugins = function(install)
	local plugin_list = {
		"vim-matchup",
		"undotree",
		"comment",
		"todo-comments",
		"comment-frame",
	}

	for _, plugin in pairs(plugin_list) do
		require("safdar.setup.others." .. plugin).install(install)
	end
end

return { get_plugins = plugins }
