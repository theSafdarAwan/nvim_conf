local plugin = function(install)
	install({
		opt = true,
		"nvim-telescope/telescope.nvim",
		setup = function()
			local plugin = {
				name = "telescope.nvim",
				on_load = {
					config = function()
						require("safdar.setup.navigation.telescope.config").config()
					end,
				},
				keymap = {
					keys = {
						{ "n", "<leader>f" },
						{ "n", "<leader>t" },
						{ "n", "<leader>c" },
						{ "n", "<leader>r" },
						{ "n", "<leader>v" },
						{ "n", "<leader>b" },
						{ "n", "<leader>d" },
						{ "n", "<C-_>" },
						{ "n", "<leader>t" },
						{ "n", "<leader>g" },
					},
				},
			}
			require("lazy-loader").load(plugin)
			require("safdar.utils").fused("telescope.nvim")
		end,
	})
	install({
		opt = true,
		setup = function()
			local plugin = {
				name = "telescope-fzf-native.nvim",
				after = "telescope.nvim",
				on_load = {
					config = function()
						require("safdar.setup.navigation.telescope.telescope-plugins").fzf()
					end,
				},
			}
			require("lazy-loader").load(plugin)
		end,
		"nvim-telescope/telescope-fzf-native.nvim",
		run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
	})
	install({
		opt = true,
		"LukasPietzschmann/telescope-tabs",
		setup = function()
			local plugin = {
				name = "telescop-tabs",
				after = "telescope-fzf-native.nvim",
				on_load = {
					config = function()
						require("safdar.setup.navigation.telescope.telescope-plugins").tabs()
						require("safdar.setup.navigation.telescope.maps").telescope_plugins_maps.tabs()
					end,
				},
			}
			require("lazy-loader").load(plugin)
		end,
	})
end

return { install = plugin }
