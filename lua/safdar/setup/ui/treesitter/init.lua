local function plugin(install)
	install({
		opt = true,
		"nvim-treesitter/nvim-treesitter",
		setup = function()
			local ts = {
				name = "nvim-treesitter",
				on_load = {
					config = function()
						require("safdar.setup.ui.treesitter.config").config()
					end,
				},
			}
			require("lazy-loader").load(ts)
			require("safdar.utils").fused("treesitter")
		end,
	})
	-- Other Plugins
	install({
		"windwp/nvim-ts-autotag",
		opt = true,
		setup = function()
			local ts_autotag = {
				name = "nvim-ts-autotag",
				on_load = {
					config = function()
						require("nvim-ts-autotag").setup()
					end,
				},
				autocmd = {
					ft = "html",
					event = "InsertEnter",
				},
			}
			require("lazy-loader").load(ts_autotag)
		end,
	})
	install({
		"p00f/nvim-ts-rainbow",
		after = "nvim-treesitter",
		setup = function()
			require("safdar.utils").fused("tsrainbow")
		end,
	})
	install({
		"nvim-treesitter/nvim-treesitter-context",
		setup = function()
			require("safdar.utils").fused("treesitter_context")
		end,
		after = "nvim-ts-rainbow",
	})
	install({
		"nvim-treesitter/nvim-treesitter-textobjects",
		after = "nvim-treesitter-context",
	})
end

return { install = plugin }
