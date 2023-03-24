--- This Plugins module includes common plugins each plugin has different purpose.

---@table Plugins plugins modules.
---@field vim_matchup Plugin extends the matchup text objects.
---@field nvim_surround Plugin adds text objects for surround words, punctuations, etc.
---@field undotree Plugin Utility for viewing and going to previous version's of the file using. Not a git plugin.
---@field Comment_nvim Plugin comment out text.
---@field todo_comments_nvim Plugin adds highlights for todo comments.
---@field nvim_comment_frame Plugin adds comment frame's when commenting very useful when
--- separating code in large files.
---@field vim_be_good Plugin ThePrimeagen Plugin for improving movement in nvim.
---@field nvim_spectre Plugin replacing text utility plugin like vscode replace option.
---@field refactoring_nvim Plugin ThePrimeagen plugin for refactoring code.
---@field nvim_window_picker Plugin window picker like tmux option for picking windows.
---@field winshift_nvim Plugin moving|shifting window's easily.
---@field focus_nvim Plugin focus the current window, has different layouts for
--- focusing it is same as the tmux layouts.

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
		"vim-be-good",
		"nvim-spectre",
		"refactoring-nvim",
		----------------------------------------------------------------------
		--                        commeting Plugins                         --
		----------------------------------------------------------------------
		"Comment-nvim",
		"todo-comments-nvim",
		"nvim-comment-frame",
		----------------------------------------------------------------------
		--                        Window Management                         --
		----------------------------------------------------------------------
		"nvim-window-picker",
		"winshift-nvim",
		"focus-nvim",
	}

	for _, plugin in pairs(Plugins) do
		require("safdar.setup.others." .. plugin).install(install)
	end
end

return { get_plugins = plugins }
