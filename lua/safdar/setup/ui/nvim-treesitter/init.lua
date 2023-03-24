local function plugin(install)
	install({
		lazy = false,
		priority = 1000,
		"nvim-treesitter/nvim-treesitter",
		init = function()
			require("fused").load_plugin("nvim-treesitter")
			-- vim.api.nvim_create_autocmd({ "BufRead", "BufWinEnter", "BufNewFile" }, {
			-- 	group = vim.api.nvim_create_augroup("lazy load treesitter", {}),
			-- 	callback = function()
			-- 		local file = vim.fn.expand("%")
			-- 		local condition = file ~= "NvimTree_1" and file ~= "[lazy]" and file ~= ""
			-- 		if condition then
			-- 			vim.api.nvim_del_augroup_by_name("lazy load treesitter")
			-- 			-- dont defer for treesitter as it will show slow highlighting
			-- 			-- This deferring only happens only when we do "nvim filename"
			-- 			require("lazy").load({ plugins = "nvim-treesitter" })
			-- 		end
			-- 	end,
			-- })
		end,
		build = ":TSUpdate",
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
	})
	install({
		"HiPhish/nvim-ts-rainbow2",
		event = "BufRead",
		init = function()
			require("fused").load_plugin("nvim-ts-rainbow2")
		end,
	})
	install({
		"JoosepAlviste/nvim-ts-context-commentstring",
		keys = "gc",
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
