local plugins = function(install)
	install({
		"williamboman/mason.nvim",
		after = "nvim-lspconfig",
		config = function()
			require("safdar.setup.lsp.mason.config").config()
		end,
	})
end
return { install = plugins }
