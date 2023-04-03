local function plugin(install)
	install({
		"mizlan/iswap.nvim",
		keys = "gsi",
		config = function()
			require("iswap").setup({
				-- Automatically swap with only two arguments
				-- default nil
				autoswap = true,
				-- Highlight group for the greyed background
				-- default 'Comment'
				hl_grey = "",
			})
			vim.keymap.set("n", "gsi", ":ISwapWith<CR>", { silent = true, noremap = true })
		end,
	})
end

return { install = plugin }
