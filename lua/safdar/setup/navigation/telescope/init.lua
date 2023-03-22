local plugin = function(install)
	install({
		"nvim-telescope/telescope.nvim",
		config = function()
			require("safdar.setup.navigation.telescope.config").config()
		end,
		init = function()
			require("safdar.utils").fused("telescope.nvim")
		end,
		keys = {
			"<leader>f",
			"<leader>t",
			"<leader>c",
			"<leader>r",
			"<leader>v",
			"<leader>b",
			"<leader>d",
			"<C-_>",
			"<leader>t",
			"<leader>g",
		},
		dependencies = {
			"telescope-fzf-native.nvim",
			"telescope-tabs",
		},
	})
	install({
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
		config = function()
			require("safdar.setup.navigation.telescope.telescope-plugins").fzf()
		end,
	})
	install({
		"LukasPietzschmann/telescope-tabs",
		config = function()
			require("safdar.setup.navigation.telescope.telescope-plugins").tabs()
			require("safdar.setup.navigation.telescope.maps").telescope_plugins_maps.tabs()
		end,
	})
end

return { install = plugin }
