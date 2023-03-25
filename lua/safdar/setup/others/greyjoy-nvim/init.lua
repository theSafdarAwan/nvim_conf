local function plugin(install)
	install({
		"desdic/greyjoy.nvim",
		keys = {
			{ "<Leader>gr", ":Greyjoy<CR>", desc = "[G]reyjoy [r]un" },
			{ "<Leader>gf", ":Greyjoy fast<CR>", desc = "[G]reyjoy run [f]ast" },
		},
		config = function()
			require("safdar.setup.others.greyjoy-nvim.config").config()
		end,
	})
end

return { install = plugin }
