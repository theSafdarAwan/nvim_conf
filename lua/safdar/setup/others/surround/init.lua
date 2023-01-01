local function plugin(install)
	install({
		"kylechui/nvim-surround",
		opt = true,
		setup = function()
			local surround = {
				name = "nvim-surround",
				on_load = {
					config = function()
						require("safdar.setup.others.surround.config").config()
					end,
				},
				keymap = {
					keys = {
						{ "v", "S" },
						{ "n", "cs" },
						{ "n", "ds" },
						{ "n", "ys" },
						{ "n", "yS" },
						{ "n", "ca" },
						{ "n", "da" },
					},
				},
			}
			require("lazy-loader").load(surround)
		end,
		-- tag = "main", -- Use for stability; omit to use `main` branch for the latest features
	})
end

return { install = plugin }
