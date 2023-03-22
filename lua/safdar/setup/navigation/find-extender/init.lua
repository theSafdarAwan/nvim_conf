local plugin = function(install)
	install({
		"TheSafdarAwan/find-extender.nvim",
		keys = {
			{ mode = "v", "f" },
			{ mode = "v", "F" },
			{ "n", "f" },
			{ "n", "F" },
			{ "n", "T" },
			{ "n", "t" },
			{ mode = "v", "T" },
			{ mode = "v", "t" },
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
