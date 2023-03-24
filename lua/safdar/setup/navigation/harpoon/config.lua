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

	vim.schedule_wrap(function()
		require("safdar.setup.navigation.telescope-nvim.telescope-plugins").harpoon()
		-- require the telescope config
		require("safdar.setup.navigation.telescope-nvim.maps").telescope_plugins_maps.harpoon()
	end)
end

return { config = config }
