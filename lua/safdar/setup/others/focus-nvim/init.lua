local function plugin(install)
	install({
		"beauwilliams/focus.nvim",
		keys = {
			"gwt",
			"gwm",
			"gw=",
			"gwd",
			"gwe",
		},
		config = function()
			require("safdar.setup.others.focus-nvim.config").config()
		end,
		cmds = { "FocusToggle", "FocusEnable" },
	})
end

return { install = plugin }
