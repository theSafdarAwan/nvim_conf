local function plugin(install)
	install({
		"feline-nvim/feline.nvim",
		after = "impatient.nvim",
		config = function()
			require("safdar.setup.ui.feline.config").config()
		end,
	})
end
return { install = plugin }
