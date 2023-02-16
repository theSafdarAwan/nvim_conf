local function plugin(install)
	install({
		opt = true,
		"pwntester/octo.nvim",
		setup = function()
			local octo = {
				name = "octo.nvim",
				on_load = {
					config = function()
						require("octo").setup()
						require("safdar.setup.git.octo.maps")
					end,
				},
				keymap = {
					keys = {
						"yg",
					},
				},
			}
			require("lazy-loader").load(octo)
		end,
	})
end
return { install = plugin }
