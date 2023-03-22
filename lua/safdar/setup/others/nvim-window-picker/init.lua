local function plugin(install)
	install({
		"s1n7ax/nvim-window-picker",
		keys = "gf",
		config = function()
			require("safdar.setup.others.nvim-window-picker.config").config()
		end,
	})
end

return { install = plugin }
