----------------------------------------------------------------------
--                     Telescope Plugins Config                     --
----------------------------------------------------------------------
local M = {}

local telescope = require("telescope")

M.fzf = function()
	telescope.load_extension("fzf")
end

M.git_worktree = function()
	telescope.load_extension("git_worktree")
end

M.tabs = function()
	require("telescope-tabs").setup({
		close_tab_shortcut_i = "<C-_>", -- if you're in insert mode
		close_tab_shortcut_n = "<C-_>", -- if you're in normal mode
	})
	require("safdar.setup.navigation.telescope.maps").telescope_plugins_maps.tabs()
end

M.harpoon = function()
	require("telescope").load_extension("harpoon")
	require("safdar.setup.navigation.telescope.maps").telescope_plugins_maps.harpoon()
end

return M
