local function plugins(install)
	local Plugins = {
		"gitsigns-nvim",
		"neogit",
		"diffview-nvim",
		"git-worktree-nvim",
		"octo-nvim",
	}

	for _, plugin in pairs(Plugins) do
		require("safdar.setup.git." .. plugin).install(install)
	end
end

return { get_plugins = plugins }
