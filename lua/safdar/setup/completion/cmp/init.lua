local function plugin(install)
	install({
		"hrsh7th/nvim-cmp",
		opt = true,
		setup = function()
			require("safdar.utils").fused("cmp")
			local cmp = {
				name = "nvim-cmp",
				on_load = {
					config = function()
						require("safdar.setup.completion.cmp.config").config()
					end,
				},
				autocmd = {
					event = "InsertEnter",
				},
			}
			require("lazy-loader").load(cmp)
		end,
	})
	install({
		"hrsh7th/cmp-nvim-lsp",
		after = "nvim-cmp",
		config = function()
			require("safdar.setup.completion.cmp.cmp-nvim-lsp").config()
		end,
	})
	install({ "hrsh7th/cmp-buffer", after = "cmp-nvim-lsp" })

	install({
		opt = true,
		"hrsh7th/cmp-nvim-lua",
		setup = function()
			local cmp_lua = {
				name = "cmp-nvim-lua",
				autocmd = {
					event = "InsertEnter",
					ft = "lua",
				},
			}
			require("lazy-loader").load(cmp_lua)
		end,
	})
	install({ "hrsh7th/cmp-nvim-lsp-signature-help", after = { "cmp-buffer" } })
	install({ "hrsh7th/cmp-emoji", after = "cmp-nvim-lsp-signature-help" })
end

return { install = plugin }
