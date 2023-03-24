--- This Plugins Module includes Plugins related to git.

---@table Plugins
---@field gitsigns_nvim Plugin shows git information in the signcolumn.
---@field neogit Plugin emacs magit replica for neovim.
---@field diffview_nvim Plugin shows diffs for the git.
---@field git_worktree_nvim Plugin git work-tree plugin.
---@field ocot_nvim Plugin create/close issues, create/merge pull request's within comfort
--- of your editor.

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
