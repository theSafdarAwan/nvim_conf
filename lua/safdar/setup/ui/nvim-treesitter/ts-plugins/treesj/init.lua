local function plugin(install)
	install({
		"Wansmer/treesj",
		keys = { "gts", "gtj", "gtt" },
		config = function()
			require("safdar.setup.ui.nvim-treesitter.ts-plugins.treesj.config").config()
		end,
	})
end

return { install = plugin }
