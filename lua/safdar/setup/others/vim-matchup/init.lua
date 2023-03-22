local function plugin(install)
	install({
		"andymass/vim-matchup",
		event = "BufEnter",
		config = function()
			require("safdar.setup.others.vim-matchup.config").config()
		end,
	})
end

return { install = plugin }
