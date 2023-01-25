local plugins = function(install)
	install({
		opt = true,
		"L3MON4D3/LuaSnip",
		setup = function()
			local luasnip = {
				name = "LuaSnip",
				autocmd = {
					events = "InsertEnter",
				},
				on_load = {
					config = function()
						require("safdar.setup.completion.luasnip.config").config()
					end,
				},
			}
			require("lazy-loader").load(luasnip)
		end,
	})
	install({ "saadparwaiz1/cmp_luasnip", after = "LuaSnip" })
end

return { install = plugins }
