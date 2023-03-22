local plugin = function(install)
	install({
		after = "impatient.nvim",
		"b0o/schemastore.nvim",
	})
	install({
		after = "schemastore.nvim",
		"neovim/nvim-lspconfig",
		config = function()
			require("safdar.setup.lsp.lspconfig.config").config()
		end,
	})
end

return { install = plugin }
