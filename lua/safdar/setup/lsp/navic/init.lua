local function plugin(install)
	install({
		"SmiteshP/nvim-navic",
		event = "BufRead",
		config = function()
			require("safdar.utils").fused("nvim-navic")
			require("safdar.setup.lsp.navic.config").config()
		end,
	})
end

return { install = plugin }
