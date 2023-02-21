local plugin = function(install)
	install({
		opt = true,
		"TheSafdarAwan/find-extender.nvim",
		keys = {
			{ "v", "f" },
			{ "v", "F" },
			{ "n", "f" },
			{ "n", "F" },
			{ "n", "F" },
			{ "n", "t" },
			{ "v", "F" },
			{ "v", "t" },
		},
		config = function()
			require("find-extender").setup()
		end,
	})
end

return { install = plugin }
