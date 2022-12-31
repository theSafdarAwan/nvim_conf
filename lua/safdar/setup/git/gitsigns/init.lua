local function plugin(install)
	install({
		opt = true,
		"lewis6991/gitsigns.nvim",
		setup = function()
			require("safdar.setup.git.gitsigns.config").setup()
		end,
	})
end

return { install = plugin }
