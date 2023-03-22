local function plugin(install)
	install({
		"ThePrimeagen/vim-be-good",
		cmd = "VimBeGood",
		keys = {
			"<leader>gg",
		},
		config = function()
			require("safdar.setup.others.vim-be-good.maps")
		end,
	})
end

return { install = plugin }
