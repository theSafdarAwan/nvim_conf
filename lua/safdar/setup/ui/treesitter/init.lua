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
		config = function()
			require("treesitter-context").setup({
				max_lines = 1, -- How many lines the window should span. Values <= 0 mean no limit.
				patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
					-- Patterns for specific filetypes
					-- If a pattern is missing, *open a PR* so everyone can benefit.
					lua = {
						"field",
					},
				},

				mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
			})
		end,
		after = "nvim-ts-rainbow",
	})
	install({
		"JoosepAlviste/nvim-ts-context-commentstring",
		after = "nvim-treesitter-textobjects",
		config = function()
			require("nvim-treesitter.configs").setup({
				context_commentstring = {
					enable = true,
					enable_autocmd = false,
				},
			})
		end,
	})

	require("safdar.setup.ui.treesitter.text-objects").install(install)
end

return { install = plugin }
