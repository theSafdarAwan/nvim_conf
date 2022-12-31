local plugin = function(install)
	install({
		"nvim-treesitter/playground",
		cmd = { "TSPlaygroundToggle", "TSHighlightCapturesUnderCursor" },
		keys = { "gtk" },
		config = function()
			require("safdar.setup.ui.ts-playground.config").config()
		end,
	})
end

return { install = plugin }
