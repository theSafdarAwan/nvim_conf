require("harpoon").setup({
	excluded_filetypes = { "harpoon" },
	menu = {
		width = vim.api.nvim_win_get_width(0) - 20,
		height = vim.api.nvim_win_get_height(0) - 25,
	},
})

-- this just when i am dealing with more then 3 files then i will go to telescope
-- to search files else i use 3 mappings for 3 files from high priority to low
-- priority fiels
require("safdar.plugins.telescope.telescope-plugins").harpoon()

-- require general mappings
require("safdar.plugins.harpoon.maps")
require("safdar.plugins.harpoon.maps").maps()
