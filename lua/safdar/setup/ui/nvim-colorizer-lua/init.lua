local function plugin(install)
	install({
		event = "CursorMoved",
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("safdar.setup.ui.nvim-colorizer-lua.config").config()
		end,
	})
end

return { install = plugin }
