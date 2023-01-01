local function plugin(install)
	install({
		"sindrets/winshift.nvim",
		config = function()
			require("safdar.setup.others.winshift.config").config()
		end,
		cmd = { "WinShift" },
		keys = {
			{ "n", "g;" },
			{ "n", "g:" },
		},
	})
end

return { install = plugin }
