local plugins = function(install)
	install({
		"L3MON4D3/LuaSnip",
		event = "InsertEnter",
		config = function()
			require("safdar.setup.completion.luasnip.config").config()
		end,
	})
	install({ "saadparwaiz1/cmp_luasnip", event = "InsertEnter" })
end

return { install = plugins }
