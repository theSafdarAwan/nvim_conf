local plugin = function(install)
	install({
		opt = true,
		"TheSafdarAwan/find-extender.nvim",
		keys = {
			{ "v", "f" },
			{ "v", "F" },
			{ "n", "f" },
			{ "n", "F" },
		},
		config = function()
			require("find-extender").setup()
		end,
	})
end

return { install = plugin }
