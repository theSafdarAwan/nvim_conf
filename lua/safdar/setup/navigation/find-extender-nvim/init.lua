local plugin = function(install)
	install({
		"TheSafdarAwan/find-extender.nvim",
		lazy = false,
		branch = "alpha",
		config = function()
			require("find-extender").setup({
				prefix = "g",
				movments = {
					lh = { use = false },
				},
			})
		end,
	})
end

return { install = plugin }
