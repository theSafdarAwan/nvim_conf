local function plugin(install)
	install({
		event = "CursorMoved",
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("safdar.setup.ui.colorizer.config").config()
		end,
	})
end

return { install = plugin }
