local function plugin(install)
	install({
		"glepnir/lspsaga.nvim",
		keys = {
			"[k",
			"[l",
			"]]",
			"[[",
			"gh",
			"gd",
		},
		config = function()
			require("safdar.setup.lsp.lsp-saga.config").config()
			require("safdar.utils").fused("lspsaga.nvim")
		end,
	})
end

return { install = plugin }
