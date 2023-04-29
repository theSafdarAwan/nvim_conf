local plugin = function(install)
	install({
		"TheSafdarAwan/find-extender.nvim",
		lazy = false,
		branch = "alpha",
		config = function()
			require("find-extender").setup({
				prefix = { enable = false },
				movements = {
					min_matches = 1,
					lh = { enable = true },
				},
				no_wait = {
					"}",
					"{",
					"[",
					"]",
					"(",
					")",
					",",
					"\"",
					":",
					";",
					"_",
					"'",
					"`",
					".",
					"+",
					"-",
					"*",
				},
			})
		end,
	})
end

return { install = plugin }
