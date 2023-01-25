local function plugin(install)
	install({
		opt = true,
		"norcalli/nvim-colorizer.lua",
		setup = function()
			local nc = {
				name = "nvim-colorizer.lua",
				on_load = {
					config = function()
						require("safdar.setup.ui.colorizer.config").config()
					end,
				},
				autocmd = {},
			}
			require("lazy-loader").load(nc)
		end,
	})
end

return { install = plugin }
