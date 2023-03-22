local plugin = function(install)
	install({
		"jose-elias-alvarez/null-ls.nvim",
		event = "BufRead",
		config = function()
			require("safdar.setup.lsp.null-ls.config").config()
			require("safdar.setup.lsp.null-ls.maps")
		end,
	})
end

return { install = plugin }
