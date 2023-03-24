local function plugin(install)
	install({
		"sindrets/winshift.nvim",
		config = function()
			require("safdar.setup.others.winshift-nvim.config").config()
		end,
		cmd = { "WinShift" },
		keys = {
			"g:",
			"g;",
		},
	})
end

return { install = plugin }
