local plugin = function(install)
	install({
		opt = true,
		keys = { { "n", "ygd" }, { "n", "ygD" } },
		"sindrets/diffview.nvim",
		setup = function()
			require("safdar.utils").fused("diffview")
		end,
		config = function()
			require("safdar.setup.git.diffview.config").config()
		end,
	})
end

return { install = plugin }
