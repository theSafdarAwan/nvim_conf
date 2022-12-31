local plugin = function(install)
	install({
		after = "nvim-lspconfig",
		"jose-elias-alvarez/null-ls.nvim",
		config = function()
			require("safdar.setup.lsp.null-ls.config").config()
		end,
	})
end

return { install = plugin }
