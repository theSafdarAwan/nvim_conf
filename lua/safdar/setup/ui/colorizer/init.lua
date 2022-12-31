local function plugin(install)
	install({
		"norcalli/nvim-colorizer.lua",
		after = "vim-matchup",
		config = function()
			require("safdar.setup.ui.colorizer.config").config()
		end,
	})
end

return { install = plugin }
