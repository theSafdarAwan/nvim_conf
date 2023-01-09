local function plugin(install)
	install({
		opt = true,
		"norcalli/nvim-colorizer.lua",
		setup = function()
			local nc = {
				name = "nvim-colorizer.lua",
				autocmd = {},
			}
			require("lazy-loader").load(nc)
		end,
		config = function()
			require("safdar.setup.ui.colorizer.config").config()
		end,
	})
end

return { install = plugin }
