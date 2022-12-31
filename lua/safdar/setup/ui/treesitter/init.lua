local function plugin(install)
	install({
		"nvim-treesitter/nvim-treesitter",
		after = "impatient.nvim",
		setup = function()
			require("safdar.utils").fused("treesitter")
		end,
		config = function()
			require("safdar.setup.ui.treesitter.config").config()
		end,
	})
	-- Other Plugins
	install({
		"windwp/nvim-ts-autotag",
		opt = true,
		setup = function()
			local ts_autotag = {
				name = "nvim-ts-autotag",
				autocmd = { ft = "html", event = "InsertEnter" },
			}
			require("lazy-loader").load(ts_autotag)
		end,
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	})
	install({
		"p00f/nvim-ts-rainbow",
		after = "nvim-treesitter",
		setup = function()
			require("safdar.utils").fused("tsrainbow")
		end,
	})
end

return { install = plugin }
