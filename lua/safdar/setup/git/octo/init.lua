local function plugin(install)
	install({
		"pwntester/octo.nvim",
		config = function()
			require("octo").setup()
			require("safdar.setup.git.octo.maps")
		end,
		keys = {
			"yg",
		},
	})
end
return { install = plugin }
