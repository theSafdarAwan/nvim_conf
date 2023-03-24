local function plugin(install)
	install({
		"ray-x/lsp_signature.nvim",
		event = "InsertEnter",
		config = function()
			require("safdar.setup.lsp.lsp-signature-nvim.config").config()
		end,
	})
end

return { install = plugin }
