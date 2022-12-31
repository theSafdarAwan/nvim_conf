local plugin = function(install)
	install({
		"kyazdani42/nvim-tree.lua",
		setup = function()
			require("safdar.utils").fused("nvimtree")
		end,
		config = function()
			require("safdar.setup.navigation.nvim-tree.config").config()
		end,
	})
end

return { install = plugin }