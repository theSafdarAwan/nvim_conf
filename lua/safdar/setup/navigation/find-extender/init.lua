local plugin = function(install)
	install({
		opt = true,
		"TheSafdarAwan/find-extender.nvim",
		keys = {
			{ "v", "f" },
			{ "v", "F" },
			{ "n", "f" },
			{ "n", "F" },
			{ "n", "T" },
			{ "n", "t" },
			{ "v", "T" },
			{ "v", "t" },
			{ "n", "c" },
			{ "n", "d" },
			{ "n", "y" },
		},
		config = function()
			require("find-extender").setup()
		end,
	})
end

return { install = plugin }
