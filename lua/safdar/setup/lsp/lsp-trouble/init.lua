local function plugin(install)
	install({
		"folke/trouble.nvim",
		keys = { { "n", "[" } },
		config = function()
			require("safdar.utils").fused("trouble.nvim")
			require("safdar.setup.lsp.lsp-trouble.config").config()
		end,
	})
end

return { install = plugin }
