local plugin = function(install)
	install({
		"TheSafdarAwan/find-extender.nvim",
		keys = {
			{ mode = "v", "f" },
			{ mode = "v", "F" },
			{ "f" },
			{ "F" },
			{ "T" },
			{ "t" },
			{ mode = "v", "T" },
			{ mode = "v", "t" },
			{ "c" },
			{ "d" },
			{ "y" },
		},
		config = function()
			require("find-extender").setup()
		end,
	})
end

return { install = plugin }
