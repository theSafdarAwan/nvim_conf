local function plugin(install)
	install({
		"ThePrimeagen/refactoring.nvim",
		keys = { "n", "v" },
		config = function()
			require("safdar.setup.others.refactoring.maps")
		end,
	})
end

return { install = plugin }
