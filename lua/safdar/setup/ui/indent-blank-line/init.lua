local function plugin(install)
	install({
		"lukas-reineke/indent-blankline.nvim",
		event = "BufReadPost",
		setup = function()
			require("safdar.utils").fused("indentblankline")
		end,
		config = function()
			require("safdar.setup.ui.indent-blank-line.config").config()
		end,
	})
end

return { install = plugin }
