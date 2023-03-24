local plugin = function(install)
	install({
		event = "BufRead",
		"b0o/schemastore.nvim",
	})
	install({
		event = "BufRead",
		"neovim/nvim-lspconfig",
		config = function()
			require("safdar.setup.lsp.nvim-lspconfig.config").config()
		end,
	})
end

return { install = plugin }
