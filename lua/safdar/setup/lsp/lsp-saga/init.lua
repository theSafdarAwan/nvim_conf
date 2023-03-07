local function plugin(install)
	install({
		"glepnir/lspsaga.nvim",
		opt = true,
		setup = function()
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
				on_load = {
					config = function()
						require("safdar.setup.lsp.lsp-saga.config").config()
					end,
				},
			}
			require("lazy-loader").load(lsp_saga)
			require("safdar.utils").fused("lspsaga.nvim")
		end,
	})
end

return { install = plugin }
