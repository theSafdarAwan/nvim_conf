local function plugin(install)
	install({
		"folke/trouble.nvim",
		keys = { mode = "n", "[" },
		config = function()
			require("fused").load_plugin("trouble.nvim")
			require("safdar.setup.lsp.trouble-nvim.config").config()
		end,
	})
end

return { install = plugin }
