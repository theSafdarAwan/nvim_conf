local function plugins(install)
	local plugin_list = {
		"gitsigns",
		"neogit",
		"diffview",
		"git-worktree",
		"octo",
	}

	for _, plugin in pairs(plugin_list) do
		require("safdar.setup.git." .. plugin).install(install)
	end
end

return { get_plugins = plugins }
