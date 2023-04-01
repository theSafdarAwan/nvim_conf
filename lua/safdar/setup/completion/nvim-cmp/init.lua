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
	install({
		"roobert/tailwindcss-colorizer-cmp.nvim",
		ft = { "css", "html" },
		-- optionally, override the default options:
		config = function()
			require("tailwindcss-colorizer-cmp").setup({
				color_square_width = 2,
			})
			require("cmp").config.formatting = {
				format = require("tailwindcss-colorizer-cmp").formatter,
			}
		end,
	})
end

return { install = plugin }
