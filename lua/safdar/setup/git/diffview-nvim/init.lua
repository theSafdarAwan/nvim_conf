local plugin = function(install)
	install({
		"sindrets/diffview.nvim",
		keys = { "ygd", "ygD" },
		config = function()
			require("fused").load_plugin("diffview.nvim")
			require("safdar.setup.git.diffview-nvim.config").config()
		end,
	})
end

return { install = plugin }
