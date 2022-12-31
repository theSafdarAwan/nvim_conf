local function plugin(install)
	install({
		"glepnir/lspsaga.nvim",
		opt = true,
		setup = function()
			require("safdar.utils").fused("lspsaga")
			local lsp_saga = {
				name = "lspsaga.nvim",
				keymap = {
					keys = {
						"[k",
						"[l",
						"]]",
						"[[",
						"gh",
						"gd",
					},
				},
			}
			require("lazy-loader").load(lsp_saga)
		end,
		config = function()
			require("safdar.setup.lsp.lsp-saga.config").config()
		end,
	})
end

return { install = plugin }
