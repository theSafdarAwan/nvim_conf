local function plugin(install)
	install({
		"uga-rosa/cmp-dictionary",
		ft = { "md", "html", "norg" },
		config = function()
			require("safdar.setup.completion.nvim-cmp-dictionary.config").config()
		end,
	})
end

return { install = plugin }
