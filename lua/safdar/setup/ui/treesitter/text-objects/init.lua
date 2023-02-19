local function plugins(install)
	install({
		"nvim-treesitter/nvim-treesitter-textobjects",
		after = "nvim-treesitter-context",
		config = function()
			require("safdar.setup.ui.treesitter.text-objects.config").config()
		end,
	})
end

return { install = plugins }
