local function plugin(install)
	install({
		lazy = false,
		priority = 1000,
		"nvim-treesitter/nvim-treesitter",
		init = function()
			require("safdar.utils").fused("nvim-treesitter")
		end,
		config = function()
			require("safdar.setup.ui.treesitter.config").config()
		end,
	})
	-- Other Plugins
	install({
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
		ft = "html",
		event = "InsertEnter",
	})
	install({
		"HiPhish/nvim-ts-rainbow2",
		after = "nvim-treesitter",
		init = function()
			require("safdar.utils").fused("nvim-ts-rainbow2")
		end,
	})
	install({
		"JoosepAlviste/nvim-ts-context-commentstring",
		after = "nvim-ts-rainbow2",
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
