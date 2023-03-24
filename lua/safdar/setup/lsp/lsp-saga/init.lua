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
			require("fused").load_plugin("lspsaga.nvim")
		end,
	})
end

return { install = plugin }
