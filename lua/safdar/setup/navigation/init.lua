--- This Plugins module includes Plugins related to navigation|movment|finding.

---@table Plugins
---@field nvim_tree_lua Plugin file explorer.
---@field telescope_nvim Plugin fuzzy finder and many more.
---@field harpoon Plugin harpoon is a file marking plugin developed by ThePrimeagen. And its blazingly fast.
---@field find_extender_nvim Plugin my plugin for extending find/till commands.

local function plugins(install)
	local Plugins = {
		"nvim-tree-lua",
		"telescope-nvim",
		"harpoon",
		"find-extender-nvim",
	}

	for _, plugin in pairs(Plugins) do
		require("safdar.setup.navigation." .. plugin).install(install)
	end
end

return { get_plugins = plugins }
