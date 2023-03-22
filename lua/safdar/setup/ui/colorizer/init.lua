local function plugin(install)
	install({
		lazy = true,
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("safdar.setup.ui.colorizer.config").config()
		end,
	})
end

return { install = plugin }
