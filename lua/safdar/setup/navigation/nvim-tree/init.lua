local plugin = function(install)
	install({
		"kyazdani42/nvim-tree.lua",
		keys = "<A-e>",
		init = function()
			require("safdar.utils").fused("nvim-tree.lua")
		end,
		config = function()
			require("safdar.setup.navigation.nvim-tree.config").config()
		end,
	})
end

return { install = plugin }
