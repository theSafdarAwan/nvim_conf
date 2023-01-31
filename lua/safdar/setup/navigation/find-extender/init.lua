local plugin = function(install)
	install({
		opt = true,
		"TheSafdarAwan/find-extender.nvim",
		keys = {
			{ "n", "f" },
		},
		config = function()
			require("find-extender").setup()
		end,
	})
end

return { install = plugin }
