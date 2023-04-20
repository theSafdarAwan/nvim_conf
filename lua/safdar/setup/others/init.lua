---@param install function
local plugins = function(install)
	local Plugins = {
		----------------------------------------------------------------------
		--                           Text Objects                           --
		----------------------------------------------------------------------
		"vim-matchup",
		"nvim-surround",
		----------------------------------------------------------------------
		--                              Utils                               --
		----------------------------------------------------------------------
		"undotree",
		"vim-repeat",
		"vim-be-good",
		"nvim-spectre",
		"refactoring-nvim",
		"neo-minimap",
		"greyjoy-nvim",
		"vim-peekaboo",
		"nvim-luaref",
		"nvim-lastplace",
		----------------------------------------------------------------------
		--                        commeting Plugins                         --
		----------------------------------------------------------------------
		"Comment-nvim",
		"todo-comments-nvim",
		"nvim-comment-frame",
		"figlet-nvim",
		"printer-nvim",
		"nerdicons-nvim",
		----------------------------------------------------------------------
		--                        Window Management                         --
		----------------------------------------------------------------------
		"smart-splits-nvim",
		"nvim-window-picker",
		"winshift-nvim",
		"focus-nvim",
	}

	for _, plugin in pairs(Plugins) do
		require("safdar.setup.others." .. plugin).install(install)
	end
end

return { get_plugins = plugins }
