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
			{ "<leader>f" },
			{ "<leader>t" },
			{ "<leader>c" },
			{ "<leader>r" },
			{ "<leader>v" },
			{ "<leader>b" },
			{ "<leader>d" },
			{ "<C-_>" },
			{ "<leader>t" },
			{ "<leader>g" },
		},
	})
	install({
		"nvim-telescope/telescope-fzf-native.nvim",
		run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
		after = "telescope.nvim",
		config = function()
			require("safdar.setup.navigation.telescope.telescope-plugins").fzf()
		end,
	})
	install({
		"LukasPietzschmann/telescope-tabs",
		after = "telescope-fzf-native.nvim",
		config = function()
			require("safdar.setup.navigation.telescope.telescope-plugins").tabs()
			require("safdar.setup.navigation.telescope.maps").telescope_plugins_maps.tabs()
		end,
	})
end

return { install = plugin }
