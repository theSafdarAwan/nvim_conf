local plugins = function(install)
	install({
		opt = true,
		"L3MON4D3/LuaSnip",
		after = "nvim-cmp",
		setup = function()
			local luasnip = {
				name = "LuaSnip",
				autocmd = {
					events = "InsertEnter",
				},
			}
			require("lazy-loader").load(luasnip)
		end,
		config = function()
			require("safdar.setup.completion.luasnip.config").config()
		end,
	})
	install({ "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" })
end

return { install = plugins }
