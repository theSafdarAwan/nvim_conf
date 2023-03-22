local plugin = function(install)
	install({
		keys = { "ygd", "ygD" },
		"sindrets/diffview.nvim",
		init = function()
			require("safdar.utils").fused("diffview.nvim")
		end,
		config = function()
			require("safdar.setup.git.diffview.config").config()
		end,
	})
end

return { install = plugin }
