local function plugin(install)
	install({
		"uga-rosa/cmp-dictionary",
		ft = { "md", "html", "norg" },
		event = "CursorMoved",
		config = function()
			require("safdar.setup.completion.cmp-dictionary.config").config()
		end,
	})
end

return { install = plugin }
