local plugin = function(install)
	install({
		after = "impatient.nvim",
		"b0o/schemastore.nvim",
	})
	install({
		"neovim/nvim-lspconfig",
		after = "nvim-navic",
		config = function()
			require("safdar.setup.lsp.lspconfig.config").config()
		end,
	})
end

return { install = plugin }
