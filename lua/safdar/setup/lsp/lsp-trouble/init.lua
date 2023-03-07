local function plugin(install)
	install({
		"folke/trouble.nvim",
		keys = { { "n", "[" } },
		setup = function()
			require("safdar.utils").fused("trouble.nvim")
		end,
		config = function()
			require("safdar.setup.lsp.lsp-trouble.config").config()
		end,
	})
end

return { install = plugin }
