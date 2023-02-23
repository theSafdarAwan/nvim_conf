local function plugin(install)
	install({
		"SmiteshP/nvim-navic",
		after = "schemastore.nvim",
		config = function()
			require("safdar.utils").fused("navic")
			require("safdar.setup.lsp.navic.config").config()
		end,
	})
end

return { install = plugin }
