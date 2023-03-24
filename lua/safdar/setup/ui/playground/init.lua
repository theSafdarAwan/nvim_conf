local plugin = function(install)
	install({
		"nvim-treesitter/playground",
		cmd = { "TSPlaygroundToggle", "TSHighlightCapturesUnderCursor" },
		keys = { "gtk" },
		config = function()
			require("safdar.setup.ui.playground.config").config()
		end,
	})
end

return { install = plugin }
