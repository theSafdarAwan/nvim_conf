local function plugin(install)
	install({
		"andymass/vim-matchup",
		after = "nvim-treesitter",
		config = function()
			require("safdar.setup.others.vim-matchup.config").config()
		end,
	})
end

return { install = plugin }
