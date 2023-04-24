local plugin = function(install)
	install({
		"TheSafdarAwan/find-extender.nvim",
		lazy = false,
		branch = "alpha",
		config = function()
			require("find-extender").setup({
				prefix = "g",
				movments = {
					lh = { enable = true },
				},
			})
		end,
	})
end

return { install = plugin }
