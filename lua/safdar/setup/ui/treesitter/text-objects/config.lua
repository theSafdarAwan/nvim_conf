local function config()
	require("nvim-treesitter.configs").setup({
		textobjects = {
			swap = {
				enable = true,
				swap_next = {
					["gsn"] = "@parameter.inner",
				},
				swap_previous = {
					["gsp"] = "@parameter.inner",
				},
			},
		},
	})
end

return { config = config }
