local function plugin(install)
	install({
		opt = true,
		"windwp/nvim-spectre",
		keys = { "=" },
		config = function()
			require("safdar.setup.others.nvim-spectre.config").config()
			require("safdar.setup.others.nvim-spectre.maps").maps()
		end,
	})
end

return { install = plugin }
