local function plugins(install)
	install({
		"nvim-treesitter/nvim-treesitter-textobjects",
		keys = { "v", "c", "gs", "gn", "gp" },
		config = function()
			require("safdar.setup.ui.treesitter.text-objects.config").config()
		end,
	})
end

return { install = plugins }
