require("nvim-treesitter.configs").setup({
	matchup = {
		enable = true, -- mandatory, false will disable the whole extension
		-- disable = { "css" }, -- optional, list of language that will be disabled
	},
})

vim.g.matchup_matchparen_offscreen = { method = "popup" }
