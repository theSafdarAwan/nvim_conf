local keys = require("safdar.setup.navigation.telescope.maps").keys
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
			require("safdar.utils").fused("telescope")
		end,
	})
	install({
		opt = true,
		setup = function()
			local plugin = {
				name = "telescope-fzf-native.nvim",
				after = "telescope.nvim",
			}
			require("lazy-loader").load(plugin)
		end,
		"nvim-telescope/telescope-fzf-native.nvim",
		run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
		config = function()
			require("safdar.setup.navigation.telescope.telescope-plugins").fzf()
		end,
	})
	install({
		opt = true,
		"LukasPietzschmann/telescope-tabs",
		setup = function()
			local plugin = {
				name = "telescope-fzf-native.nvim",
				after = "telescope-fzf-native.nvim",
			}
			require("lazy-loader").load(plugin)
		end,
		config = function()
			require("safdar.setup.navigation.telescope.telescope-plugins").tabs()
		end,
	})
end

return { install = plugin }
