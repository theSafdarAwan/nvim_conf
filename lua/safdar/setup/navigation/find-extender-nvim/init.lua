local plugin = function(install)
	install({
		"TheSafdarAwan/find-extender.nvim",
		lazy = false,
		branch = "alpha",
		config = function()
			require("find-extender").setup({
				prefix = { enable = false },
				input_length = 2,
				movements = {
					min_matches = 1,
					leap = {
						enable = false,
					},
					lh = {
						enable = true,
						go_to_first_match = false,
					},
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
