--- This Plugins module includes plugins related to treesitter
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
			   require("safdar.setup.ui.nvim-treesitter.config").config()
		end,
	})

	require("safdar.setup.ui.nvim-treesitter.ts-plugins").install(install)
end

return { install = plugin }
