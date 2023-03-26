local function plugin(install)
	install({
		"nvim-lualine/lualine.nvim",
		event = "VimEnter",
		config = function()
			require("safdar.setup.ui.lualine-nvim.config").config()
		end,
		dependencies = { "kyazdani42/nvim-web-devicons" },
	})
end
return { install = plugin }
