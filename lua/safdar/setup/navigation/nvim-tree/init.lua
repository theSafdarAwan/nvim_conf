local plugin = function(install)
	install({
		"kyazdani42/nvim-tree.lua",
		lazy = false,
		init = function()
			require("safdar.utils").fused("nvim-tree.lua")
		end,
		dependencies = { "nvim-web-devicons" },
		config = function()
			require("safdar.setup.navigation.nvim-tree.config").config()
		end,
	})
end

return { install = plugin }
