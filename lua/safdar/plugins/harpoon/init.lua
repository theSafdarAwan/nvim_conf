require("harpoon").setup({
	excluded_filetypes = { "harpoon" },
	menu = {
		width = vim.api.nvim_win_get_width(0) - 20,
		height = vim.api.nvim_win_get_height(0) - 25,
	},
})

-- require general mappings
require("safdar.plugins.harpoon.maps")
require("safdar.plugins.harpoon.maps").maps()
