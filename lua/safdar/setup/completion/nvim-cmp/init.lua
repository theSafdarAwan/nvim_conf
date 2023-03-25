local function plugin(install)
	install({
		"hrsh7th/nvim-cmp",
		config = function()
			require("fused").load_plugin("nvim-cmp")
			require("safdar.setup.completion.nvim-cmp.config").config()
		end,
		event = "InsertEnter",
	})
	install({
		"hrsh7th/cmp-nvim-lsp",
		event = "InsertEnter",
		config = function()
			require("safdar.setup.completion.nvim-cmp.cmp-nvim-lsp").config()
		end,
	})
	install({ "hrsh7th/cmp-buffer", event = "InsertEnter" })

	install({
		"hrsh7th/cmp-nvim-lua",
		ft = "lua",
	})
	install({
		"hrsh7th/cmp-emoji",
		keys = { mode = "i", ":" },
	})
end

return { install = plugin }
