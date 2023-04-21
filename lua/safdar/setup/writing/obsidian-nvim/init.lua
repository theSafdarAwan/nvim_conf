local function Plugin(install)
	install({
		"epwalsh/obsidian.nvim",
		ft = "markdown",
		dependencies = "hrsh7th/nvim-cmp",
		config = function()
			require("obsidian").setup({
				dir = "~/safdar-local/NOTES/Obsidian/",
				completion = {
					nvim_cmp = true, -- if using nvim-cmp, otherwise set to false
				},
			})
		end,
	})
end

return { install = Plugin }
