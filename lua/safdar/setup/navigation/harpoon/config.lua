local maps = require("safdar.setup.navigation.harpoon.maps").maps

local config = function()
	require("harpoon").setup({
		excluded_filetypes = { "harpoon" },
		menu = {
			width = vim.api.nvim_win_get_width(0) - 20,
			height = vim.api.nvim_win_get_height(0) - 25,
		},
	})
	maps()
end

return { config = config }
