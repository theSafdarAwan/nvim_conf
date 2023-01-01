local function plugin(install)
	install({
		"RRethy/vim-illuminate",
		config = function()
			require("safdar.setup.ui.vim-illuminate.config").config()
		end,
		event = { "CursorMoved" },
	})
end

return { install = plugin }
