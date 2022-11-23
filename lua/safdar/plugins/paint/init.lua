require("paint").setup({
	-- @type PaintHighlight[]
	highlights = {
		{
			filter = { filetype = "lua" },
			pattern = "%s(@%w+)",
			-- pattern = "%s*%-%-%-%s*(@%w+)",
			hl = "@parameter",
		},
		{
			filter = { filetype = "c" },
			-- pattern = "%s*%/%/%/%s*(@%w+)",
			pattern = "%s(@%w+)",
			hl = "@parameter",
		},
	},
})
