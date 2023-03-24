local function plugin(install)
	install({
		"kylechui/nvim-surround",
		config = function()
			require("safdar.setup.others.nvim-surround.config").config()
		end,
		event = "CursorMoved",
	})
end

return { install = plugin }
