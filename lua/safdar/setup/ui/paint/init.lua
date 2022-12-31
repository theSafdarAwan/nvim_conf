local function plugin(install)
	install({
		opt = true,
		"folke/paint.nvim",
		after = "nvim-treesitter",
		config = function()
			require("safdar.setup.ui.paint.config").config()
		end,
	})
end

return { install = plugin }
