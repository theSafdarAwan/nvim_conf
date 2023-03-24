local function plugin(install)
	install({
		"lukas-reineke/indent-blankline.nvim",
		event = "BufReadPost",
		init = function()
			require("fused").load_plugin("indent-blankline.nvim")
		end,
		config = function()
			require("safdar.setup.ui.indent-blank-line.config").config()
		end,
	})
end

return { install = plugin }
