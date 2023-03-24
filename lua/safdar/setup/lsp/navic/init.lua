local function plugin(install)
	install({
		"SmiteshP/nvim-navic",
		event = "BufRead",
		config = function()
			require("fused").load_plugin("nvim-navic")
			require("safdar.setup.lsp.navic.config").config()
		end,
	})
end

return { install = plugin }
