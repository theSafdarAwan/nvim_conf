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
		},
		config = function()
			require("find-extender").setup()
		end,
	})
end

return { install = plugin }
