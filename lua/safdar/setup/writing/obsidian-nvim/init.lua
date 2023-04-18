local function Plugin(install)
	install({
		"epwalsh/obsidian.nvim",
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
