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
		"JoosepAlviste/nvim-ts-context-commentstring",
		after = "nvim-ts-rainbow",
		config = function()
			-- TODO: work on this type of nodes injected in js

			--[[
			    <div class='${data.className}'>
				    Your favorite color is now ${data.color}
				</div>
			`; ]]

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
