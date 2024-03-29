local function plugin(install)
	install({
		"ThePrimeagen/refactoring.nvim",
		keys = { "v", "V" },
		config = function()
			require("safdar.setup.others.refactoring-nvim.maps")
		end,
	})
end

return { install = plugin }
