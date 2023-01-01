local function plugin(install)
	install({
		"beauwilliams/focus.nvim",
		keys = { "gF", "go", "g," },
		config = function()
			require("safdar.setup.others.focus.config").config()
		end,
		cmd = { "FocusToggle", "FocusEnable" },
	})
end

return { install = plugin }
