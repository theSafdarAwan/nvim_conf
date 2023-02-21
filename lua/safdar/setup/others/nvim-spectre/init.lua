local function plugin(install)
	install({
		"windwp/nvim-spectre",
		config = function()
			require("safdar.setup.others.nvim-spectre.config").config()
			require("safdar.setup.others.nvim-spectre.maps").maps()
		end,
	})
end

return { install = plugin }
