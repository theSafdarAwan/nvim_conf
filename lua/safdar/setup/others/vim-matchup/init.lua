local function plugin(install)
	install({
		"andymass/vim-matchup",
		lazy = false,
		config = function()
			require("safdar.setup.others.vim-matchup.config").config()
		end,
	})
end

return { install = plugin }
