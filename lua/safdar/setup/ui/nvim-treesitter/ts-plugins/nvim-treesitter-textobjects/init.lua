local function plugins(install)
	install({
		"nvim-treesitter/nvim-treesitter-textobjects",
		event = "CursorMoved",
		config = function()
			require("safdar.setup.ui.nvim-treesitter.ts-plugins.nvim-treesitter-textobjects.config").config()
		end,
	})
end

return { install = plugins }
