local function Plugin(install)
	install({
		lazy = false,
		"nanozuki/tabby.nvim",
		config = function()
			require("safdar.setup.ui.tabby-nvim.config").config()
		end,
	})
end

return { install = Plugin }
