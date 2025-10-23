local plugin = function(install)
	install({
		"nvimtools/none-ls.nvim",
		event = "BufRead",
		config = function()
			require("safdar.setup.lsp.null-ls-nvim.config").config()
			require("safdar.setup.lsp.null-ls-nvim.maps")
		end,
	})
end

return { install = plugin }
